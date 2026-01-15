#import <Foundation/Foundation.h>
#import <AgoraRtcKit/AgoraRteKit.h>

// 共享的宏定义和辅助函数

#define RTE_NSERROR(errCode, msg) \
    [NSError errorWithDomain:@"AgoraRTE" code:errCode userInfo:@{NSLocalizedDescriptionKey: msg ?: @"Unknown error"}]

static inline NSString * _Nullable SafeGetRteErrorMessage(AgoraRteError * _Nullable rteError) {
    if (!rteError) {
        return nil;
    }
    AgoraRteErrorCode code = [rteError code];
    return [NSString stringWithFormat:@"RTE Error (code: %ld)", (long)code];
}

#define RTE_NSERROR_FROM_RTE_ERROR(rteError) \
    RTE_NSERROR([rteError code], SafeGetRteErrorMessage(rteError))

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
