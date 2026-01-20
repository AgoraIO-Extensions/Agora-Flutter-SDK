#import <Foundation/Foundation.h>
#import <AgoraRtcKit/AgoraRteKit.h>

// Shared macros and helper functions

#define RTE_NSERROR(errCode, msg) \
    [NSError errorWithDomain:@"AgoraRTE" code:errCode userInfo:@{NSLocalizedDescriptionKey: msg ?: @"Unknown error"}]

static inline NSString * _Nullable SafeGetRteErrorMessage(AgoraRteError * _Nullable rteError) {
    if (!rteError) {
        return nil;
    }
    AgoraRteErrorCode code = [rteError code];
    return [NSString stringWithFormat:@"RTE Error (code: %ld)", (long)code];
}

// Generate error message with location (including line number)
static inline NSString * _Nonnull SafeGetRteErrorMessageWithLocation(AgoraRteError * _Nullable rteError, NSString * _Nonnull location, NSInteger lineNumber) {
    if (!rteError) {
        return [NSString stringWithFormat:@"%@:%ld: Unknown error", location, (long)lineNumber];
    }
    AgoraRteErrorCode code = [rteError code];
    NSString *message = [rteError message];
    if (message && message.length > 0) {
        return [NSString stringWithFormat:@"%@:%ld: RTE Error (code: %ld, message: %@)", location, (long)lineNumber, (long)code, message];
    } else {
        return [NSString stringWithFormat:@"%@:%ld: RTE Error (code: %ld)", location, (long)lineNumber, (long)code];
    }
}

// Extract function name from __PRETTY_FUNCTION__
static inline NSString * _Nonnull ExtractFunctionName(const char * _Nullable prettyFunction) {
    NSString *funcStr = @(prettyFunction);
    // For Objective-C methods, format: -[ClassName methodName:param1:param2:]
    // Extract ClassName.methodName part
    NSRange range = [funcStr rangeOfString:@"-["];
    if (range.location != NSNotFound) {
        NSRange endRange = [funcStr rangeOfString:@":"];
        if (endRange.location != NSNotFound) {
            NSString *methodPart = [funcStr substringWithRange:NSMakeRange(range.location + 2, endRange.location - range.location - 2)];
            return methodPart;
        }
    }
    // For C functions, return as is
    return funcStr;
}

// Original macro for backward compatibility (auto-includes function name and line number)
#define RTE_NSERROR_FROM_RTE_ERROR(rteError) \
    RTE_NSERROR([rteError code], SafeGetRteErrorMessageWithLocation(rteError, ExtractFunctionName(__PRETTY_FUNCTION__), __LINE__))

// Macro with location (recommended, auto-includes line number)
#define RTE_NSERROR_FROM_RTE_ERROR_WITH_LOCATION(rteError, location) \
    RTE_NSERROR([rteError code], SafeGetRteErrorMessageWithLocation(rteError, location, __LINE__))

#define CHECK_RTE_INSTANCE(rteInstance, error) \
    if (!rteInstance) { \
        if (error) *error = RTE_NSERROR(-1, @"RTE instance not created"); \
        return NO; \
    }

#define CHECK_RTE_INSTANCE_NIL(rteInstance, error) \
    if (!rteInstance) { \
        if (error) *error = RTE_NSERROR(-1, @"RTE instance not created"); \
        return nil; \
    }

#define GET_PLAYER_OR_RETURN(players, playerId, error, retVal) \
    AgoraRtePlayer *player = players[playerId]; \
    if (!player) { \
        if (error) *error = RTE_NSERROR(-1, @"Player not found"); \
        return retVal; \
    }

#define GET_CANVAS_OR_RETURN(canvases, canvasId, error, retVal) \
    AgoraRteCanvas *canvas = canvases[canvasId]; \
    if (!canvas) { \
        if (error) *error = RTE_NSERROR(-1, @"Canvas not found"); \
        return retVal; \
    }
