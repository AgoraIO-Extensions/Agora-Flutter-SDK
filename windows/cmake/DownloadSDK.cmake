function(DownloadSDK platform version download_dir)
  # Specify the binary distribution type and download directory.
  set(SDK_DISTRIBUTION "Agora_Native_SDK_for_${platform}_${version}_IRIS")
  set(SDK_DOWNLOAD_DIR "${download_dir}")

  # The location where we expect the extracted binary distribution.
  set(SDK_ROOT "${SDK_DOWNLOAD_DIR}/Agora_Native_SDK_for_${platform}_IRIS" CACHE INTERNAL "SDK_ROOT")

  # Download and/or extract the binary distribution if necessary.
  if(NOT IS_DIRECTORY "${SDK_ROOT}")
    set(SDK_DOWNLOAD_FILENAME "${SDK_DISTRIBUTION}.zip")
    set(SDK_DOWNLOAD_PATH "${SDK_DOWNLOAD_DIR}/${SDK_DOWNLOAD_FILENAME}")
    if(NOT EXISTS "${SDK_DOWNLOAD_PATH}")
      set(SDK_DOWNLOAD_URL "https://download.agora.io/sdk/release/${SDK_DOWNLOAD_FILENAME}")
      string(REPLACE "+" "%2B" SDK_DOWNLOAD_URL_ESCAPED ${SDK_DOWNLOAD_URL})

      # Download the binary distribution and verify the hash.
      message(STATUS "Downloading ${SDK_DOWNLOAD_PATH}...")
      file(
        DOWNLOAD "${SDK_DOWNLOAD_URL_ESCAPED}" "${SDK_DOWNLOAD_PATH}"
        SHOW_PROGRESS
        )
    endif()

    # Extract the binary distribution.
    message(STATUS "Extracting ${SDK_DOWNLOAD_PATH}...")
    execute_process(
      COMMAND ${CMAKE_COMMAND} -E tar xzf "${SDK_DOWNLOAD_DIR}/${SDK_DOWNLOAD_FILENAME}"
      WORKING_DIRECTORY ${SDK_DOWNLOAD_DIR}
      )
  endif()
endfunction()

function(DOWNLOAD_SDK_BY_URL download_url download_dir)
    # Specify the binary distribution type and download directory.
    STRING(REGEX REPLACE ".+/(.+)\\..*" "\\1" SDK_DISTRIBUTION ${download_url})
    message(STATUS "SDK_DISTRIBUTION ${SDK_DISTRIBUTION}")
    set(SDK_DOWNLOAD_DIR "${download_dir}")

    # The location where we expect the extracted binary distribution.
    set(SDK_ROOT "${SDK_DOWNLOAD_DIR}/${SDK_DISTRIBUTION}" CACHE INTERNAL "SDK_ROOT")

    # Download and/or extract the binary distribution if necessary.
    if (NOT IS_DIRECTORY "${SDK_ROOT}")
        set(SDK_DOWNLOAD_FILENAME "${SDK_DISTRIBUTION}.zip")
        set(SDK_DOWNLOAD_PATH "${SDK_DOWNLOAD_DIR}/${SDK_DOWNLOAD_FILENAME}")
        if (NOT EXISTS "${SDK_DOWNLOAD_PATH}")
            set(SDK_DOWNLOAD_URL "${download_url}")
            string(REPLACE "+" "%2B" SDK_DOWNLOAD_URL_ESCAPED ${SDK_DOWNLOAD_URL})

            # Download the binary distribution and verify the hash.
            message(STATUS "Downloading ${SDK_DOWNLOAD_PATH}...")
            file(
                    DOWNLOAD "${SDK_DOWNLOAD_URL_ESCAPED}" "${SDK_DOWNLOAD_PATH}"
                    SHOW_PROGRESS
            )
        endif ()

        # Extract the binary distribution.
        message(STATUS "Extracting ${SDK_DOWNLOAD_PATH}...")
        execute_process(
                COMMAND ${CMAKE_COMMAND} -E tar xzf "${SDK_DOWNLOAD_DIR}/${SDK_DOWNLOAD_FILENAME}"
                WORKING_DIRECTORY ${SDK_DOWNLOAD_DIR}
        )
    endif ()
endfunction()
