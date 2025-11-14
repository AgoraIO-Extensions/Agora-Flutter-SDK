# iris dependencies start
set(IRIS_SDK_DOWNLOAD_URL "https://download.agora.io/sdk/release/iris_4.5.2.2-build.3_DCG_Windows_Video_Standalone_20250828_0610_31765.zip")
# iris dependencies end

# native dependencies start
set(NATIVE_SDK_DOWNLOAD_URL "https://download.agora.io/sdk/release/Agora_Native_SDK_for_Windows_rel.v4.5.2.6_30545_FULL_20251105_1129_962464.zip")
# native dependencies end

function(download_and_extract URL TARGET_DIR EXTRACTED_DIR)
    message(STATUS "Downloading ${URL} to ${TARGET_DIR}")

    # Escape the URL for the command line
    string(REPLACE "+" "%2B" URL_ESCAPED ${URL})

    # Extract the file name from the URL
    STRING(REGEX REPLACE ".+/(.+)\\..*" "\\1" SOURCE_FILE_NAME ${URL_ESCAPED})
    message(STATUS "Source file name: ${SOURCE_FILE_NAME}")

    # Set the target file path
    set(TARGET_FILE "${TARGET_DIR}/${SOURCE_FILE_NAME}.zip")
    message(STATUS "Target file: ${TARGET_FILE}")

    # Download the file if it doesn't exist
    if(NOT EXISTS "${TARGET_FILE}")
        file(DOWNLOAD ${URL_ESCAPED} ${TARGET_FILE} SHOW_PROGRESS STATUS status)
        list(GET status 0 status_code)
        list(GET status 1 status_string)
        if(NOT status_code EQUAL 0)
          # Remove the file if it exists when the download fails
          if(EXISTS "${TARGET_FILE}")
            file(REMOVE "${TARGET_FILE}")
          endif()
          message(FATAL_ERROR "Download failed: ${STATUS_STRING}")
        endif()
    endif()

    # Remove the extracted directory if it exists
    if(EXISTS "${EXTRACTED_DIR}")
      file(REMOVE_RECURSE "${EXTRACTED_DIR}")
    endif()

    # Create the extracted directory if it doesn't exist
    file(MAKE_DIRECTORY "${EXTRACTED_DIR}")

    # Extract the file
    execute_process(
        COMMAND ${CMAKE_COMMAND} -E tar xzf "${TARGET_FILE}"
        WORKING_DIRECTORY ${EXTRACTED_DIR}
    )
endfunction()

set(CONST_EXTRACTED_DIR_NAME "lib")

# Download and extract the Iris SDK
set(IRIS_DOWNLOAD_PATH "${CMAKE_CURRENT_SOURCE_DIR}/third_party/iris")
set(IRIS_EXTRACTED_DIR "${IRIS_DOWNLOAD_PATH}/${CONST_EXTRACTED_DIR_NAME}")

# Download and extract the Iris SDK if the plugin is not in development mode
if(NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/.plugin_dev")
    download_and_extract("${IRIS_SDK_DOWNLOAD_URL}" "${IRIS_DOWNLOAD_PATH}" "${IRIS_EXTRACTED_DIR}")
endif()

# Fixed the include directory and library directory names of Iris SDK by current build architecture
if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    set(IRIS_ARCH "x64")
else()
    set(IRIS_ARCH "Win32")
endif()
set(IRIS_INCLUDE_DIR_REGEX "${IRIS_ARCH}/include")
set(IRIS_LIB_DIR_REGEX "${IRIS_ARCH}/Release")

# Find include directory and library directory of Iris SDK from the extracted directory by regex
set(IRIS_INCLUDE_DIR "")
set(IRIS_LIB_DIR "")

file(GLOB_RECURSE IRIS_DIRECTORIES LIST_DIRECTORIES true "${IRIS_EXTRACTED_DIR}/*")
foreach(SUBDIR ${IRIS_DIRECTORIES})
  STRING(REGEX MATCH "${IRIS_INCLUDE_DIR_REGEX}$" FIND_INCLUDE_DIR "${SUBDIR}")
  STRING(REGEX MATCH "${IRIS_LIB_DIR_REGEX}$" FIND_LIB_DIR "${SUBDIR}")
  if(FIND_INCLUDE_DIR)
    set(IRIS_INCLUDE_DIR "${SUBDIR}")
  endif()
  if(FIND_LIB_DIR)
    set(IRIS_LIB_DIR "${SUBDIR}")
  endif()
  if(IRIS_INCLUDE_DIR AND IRIS_LIB_DIR) 
    break()
  endif()
endforeach()

# Print and verify the include directory and library directory of Iris SDK
if(IRIS_INCLUDE_DIR STREQUAL "" OR IRIS_LIB_DIR STREQUAL "")
  message(WARNING "IRIS_INCLUDE_DIR: ${IRIS_INCLUDE_DIR}")
  message(WARNING "IRIS_LIB_DIR: ${IRIS_LIB_DIR}")
  message(FATAL_ERROR "Failed to find include directory and library directory of Iris SDK")
endif()


# Download and extract the Native SDK
set(NATIVE_DOWNLOAD_PATH "${CMAKE_CURRENT_SOURCE_DIR}/third_party/native")
set(NATIVE_EXTRACTED_DIR "${NATIVE_DOWNLOAD_PATH}/${CONST_EXTRACTED_DIR_NAME}")

# Download and extract the Native SDK if the plugin is not in development mode
if(NOT EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/.plugin_dev")
    download_and_extract("${NATIVE_SDK_DOWNLOAD_URL}" "${NATIVE_DOWNLOAD_PATH}" "${NATIVE_EXTRACTED_DIR}")
endif()

# Fixed the root directory of Native SDK to */sdk coz sdk has a fixed directory structure
set(NATIVE_SDK_ROOT "")
set(NATIVE_SDK_ROOT_REGEX "sdk")
file(GLOB_RECURSE NATIVE_DIRECTORIES LIST_DIRECTORIES true "${NATIVE_EXTRACTED_DIR}/*")
foreach(SUBDIR ${NATIVE_DIRECTORIES})
  STRING(REGEX MATCH "${NATIVE_SDK_ROOT_REGEX}$" FIND_SDK_ROOT "${SUBDIR}")
  if(FIND_SDK_ROOT)
    set(NATIVE_SDK_ROOT "${SUBDIR}")
    break()
  endif()
endforeach()

# Print and verify the root directory of Native SDK
if(NATIVE_SDK_ROOT STREQUAL "")
  message(WARNING "NATIVE_SDK_ROOT: ${NATIVE_SDK_ROOT}")
  message(FATAL_ERROR "Failed to find root directory of Native SDK")
endif()

set(NATIVE_INCLUDE_DIR "${NATIVE_SDK_ROOT}/high_level_api/include")
if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    set(NATIVE_LIB_DIR "${NATIVE_SDK_ROOT}/x86_64")
else()
    set(NATIVE_LIB_DIR "${NATIVE_SDK_ROOT}/x86")
endif()
