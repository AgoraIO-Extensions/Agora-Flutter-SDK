#import "AgoraRtcNgPlugin.h"
#import "AgoraSurfaceViewFactory.h"
#import "AgoraUtils.h"
#import "VideoViewController.h"

@interface AgoraNativeView : UIView

@end

@implementation AgoraNativeView

@end

@interface AgoraRtcNgPlugin ()

@property(nonatomic) NSObject<FlutterPluginRegistrar> *registrar;

@property(nonatomic) FlutterMethodChannel *channel;

@property(nonatomic) VideoViewController *videoViewController;

@property(nonatomic) AgoraPIPController *pipController;

@property(nonatomic, strong) NSMutableArray *_Nonnull nativeViews;

@end

@implementation AgoraRtcNgPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar> *)registrar {
  AgoraRtcNgPlugin *instance = [[AgoraRtcNgPlugin alloc] init];
  instance.registrar = registrar;

  // Initialize nativeViews array
  instance.nativeViews = [[NSMutableArray alloc] init];

  // create method channel
  FlutterMethodChannel *channel =
      [FlutterMethodChannel methodChannelWithName:@"agora_rtc_ng"
                                  binaryMessenger:[registrar messenger]];
  instance.channel = channel;
  [registrar addMethodCallDelegate:(NSObject<FlutterPlugin> *)instance
                           channel:channel];

  // create video view controller
  instance.videoViewController =
      [[VideoViewController alloc] initWith:registrar.textures
                                  messenger:registrar.messenger];
  [registrar registerViewFactory:[[AgoraSurfaceViewFactory alloc]
                                       initWith:[registrar messenger]
                                     controller:instance.videoViewController]
                          withId:@"AgoraSurfaceView"];

  // create pip controller
  instance.pipController = [[AgoraPIPController alloc]
      initWith:(id<AgoraPIPStateChangedDelegate>)instance];
}

- (void)handleMethodCall:(FlutterMethodCall *)call
                  result:(FlutterResult)result {
  AGORA_LOG(@"handleMethodCall: %@ with arguments: %@", call.method,
            call.arguments);
            
  if ([@"getAssetAbsolutePath" isEqualToString:call.method]) {
    [self getAssetAbsolutePath:call result:result];
  } else if ([call.method hasPrefix:@"pip"]) {
    [self handlePipMethodCall:call result:result];
  } else if ([call.method hasPrefix:@"nativeView"]) {
    [self handleNativeViewMethodCall:call result:result];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

- (void)getAssetAbsolutePath:(FlutterMethodCall *)call
                      result:(FlutterResult)result {
  NSString *assetPath = (NSString *)[call arguments];
  if (assetPath) {
    NSString *assetKey = [[self registrar] lookupKeyForAsset:assetPath];
    if (assetKey) {
      NSString *realPath = [[NSBundle mainBundle] pathForResource:assetKey
                                                           ofType:nil];
      result(realPath);
      return;
    }
    result([FlutterError errorWithCode:@"FileNotFoundException"
                               message:nil
                               details:nil]);
    return;
  }
  result([FlutterError errorWithCode:@"IllegalArgumentException"
                             message:nil
                             details:nil]);
}

- (void)handlePipMethodCall:(FlutterMethodCall *)call
                     result:(FlutterResult)result {
  if ([@"pipIsSupported" isEqualToString:call.method]) {
    result([NSNumber numberWithBool:[self.pipController isSupported]]);
  } else if ([@"pipIsAutoEnterSupported" isEqualToString:call.method]) {
    result([NSNumber numberWithBool:[self.pipController isAutoEnterSupported]]);
  } else if ([@"pipIsActivated" isEqualToString:call.method]) {
    result([NSNumber numberWithBool:[self.pipController isActivated]]);
  } else if ([@"pipSetup" isEqualToString:call.method]) {
    @autoreleasepool {
      // new options
      AgoraPIPOptions *options = [[AgoraPIPOptions alloc] init];

      // auto enter
      if ([call.arguments objectForKey:@"autoEnterEnabled"]) {
        options.autoEnterEnabled =
            [[call.arguments objectForKey:@"autoEnterEnabled"] boolValue];
      }

      // contentView
      if ([call.arguments objectForKey:@"contentView"]) {
        options.contentView = (__bridge UIView *)[[call.arguments
            objectForKey:@"contentView"] pointerValue];
      } else {
        // MUST set contentView
        return result([NSNumber numberWithBool:NO]);
      }

      // sourceContentView
      if ([call.arguments objectForKey:@"sourceContentView"]) {
        options.sourceContentView = (__bridge UIView *)[[call.arguments
            objectForKey:@"sourceContentView"] pointerValue];
      }

      // preferred content size
      if ([call.arguments objectForKey:@"preferredContentWidth"] &&
          [call.arguments objectForKey:@"preferredContentHeight"]) {
        options.preferredContentSize = CGSizeMake(
            [[call.arguments objectForKey:@"preferredContentWidth"] floatValue],
            [[call.arguments objectForKey:@"preferredContentHeight"]
                floatValue]);
      }

      // control style
      if ([call.arguments objectForKey:@"controlStyle"]) {
        options.controlStyle =
            [[call.arguments objectForKey:@"controlStyle"] intValue];
      }

      result([NSNumber numberWithBool:[self.pipController setup:options]]);
    }
  } else if ([@"pipStart" isEqualToString:call.method]) {
    result([NSNumber numberWithBool:[self.pipController start]]);
  } else if ([@"pipStop" isEqualToString:call.method]) {
    [self.pipController stop];
    result(nil);
  } else if ([@"pipDispose" isEqualToString:call.method]) {
    [self.pipController dispose];
    result(nil);
  } else {
    result(FlutterMethodNotImplemented);
  }
}

/**
 * Handles native view related method calls from Flutter.
 * @param call The method call from Flutter
 * @param result The result callback
 */
- (void)handleNativeViewMethodCall:(FlutterMethodCall *)call
                            result:(FlutterResult)result {
  @autoreleasepool {
    if ([@"nativeViewCreate" isEqualToString:call.method]) {
      // Create a new native UIView and store it with its pointer as the ID
      UIView *view = [[AgoraNativeView alloc] init];
      if (!view) {
        result(nil);
        return;
      }

      [self.nativeViews addObject:view];

      view.translatesAutoresizingMaskIntoConstraints = NO;

      result(@((uint64_t)view));
    } else if ([@"nativeViewDestroy" isEqualToString:call.method]) {
      // Validate arguments
      if (![call.arguments isKindOfClass:[NSNumber class]]) {
        result(nil);
        return;
      }

      uint64_t viewId = [call.arguments unsignedLongLongValue];
      UIView *view = [self findNativeView:viewId];

      if (view) {
        [view removeFromSuperview]; // Remove from parent view hierarchy
        [self.nativeViews removeObject:view]; // Remove from our array
        view = nil;                           // Clear the reference
      }

      result(nil);

    } else if ([@"nativeViewSetParent" isEqualToString:call.method]) {
      // Validate arguments
      if (![call.arguments isKindOfClass:[NSDictionary class]]) {
        result(@NO);
        return;
      }

      NSDictionary *params = call.arguments;
      NSNumber *viewIdNum = params[@"nativeViewId"];

      if (!viewIdNum || ![viewIdNum isKindOfClass:[NSNumber class]]) {
        result(@NO);
        return;
      }

      UIView *view = [self findNativeView:[viewIdNum unsignedLongLongValue]];
      if (!view) {
        result(@NO);
        return;
      }

      UIView *parentView = nil;
      NSNumber *parentViewIdNum = params[@"parentNativeViewId"];
      if (parentViewIdNum && [parentViewIdNum isKindOfClass:[NSNumber class]]) {
        parentView =
            [self findNativeView:[parentViewIdNum unsignedLongLongValue]];
      }

      // remove from previous parent view only it has a parent view and is not
      // the same as the new parent view, even if the new parent view is nil
      if (view.superview && view.superview != parentView) {
        [view removeFromSuperview];
      }

      // if parent view is nil, return true, which means the caller only want to
      // remove the view from its parent view
      if (!parentView) {
        result(@YES);
        return;
      }

      NSNumber *indexOfParentView = params[@"indexOfParentView"];

      // if view is not in parent view, insert to new parent view at index if
      // specified
      if (view.superview != parentView) {
        // insert to new parent view at index if specified
        if (indexOfParentView &&
            [indexOfParentView isKindOfClass:[NSNumber class]]) {
          [parentView insertSubview:view atIndex:[indexOfParentView intValue]];
        } else {
          [parentView addSubview:view];
        }
      } else if (indexOfParentView &&
                 [indexOfParentView isKindOfClass:[NSNumber class]]) {
        // remove and reinsert to new index if it is not the same with the
        // specified index
        if ([indexOfParentView intValue] !=
            [parentView.subviews indexOfObject:view]) {
          [view removeFromSuperview];
          [parentView insertSubview:view atIndex:[indexOfParentView intValue]];
        }
      }

      result(@YES);
    } else if ([@"nativeViewSetLayout" isEqualToString:call.method]) {
      // Validate arguments
      if (![call.arguments isKindOfClass:[NSDictionary class]]) {
        result(@NO);
        return;
      }

      NSDictionary *params = call.arguments;
      NSNumber *viewIdNum = params[@"nativeViewId"];

      if (!viewIdNum || ![viewIdNum isKindOfClass:[NSNumber class]]) {
        result(@NO);
        return;
      }

      UIView *view = [self findNativeView:[viewIdNum unsignedLongLongValue]];
      if (!view) {
        result(@NO);
        return;
      }

      // Handle layout properties
      id contentViewLayoutObj = params[@"contentViewLayout"];
      if (contentViewLayoutObj &&
          [contentViewLayoutObj isKindOfClass:[NSDictionary class]]) {
        [self applyContentViewLayout:(NSDictionary *)contentViewLayoutObj
                              toView:view];
      }

      result(@YES);
    } else {
      result(FlutterMethodNotImplemented);
    }
  }
}

- (void)pipStateChanged:(AgoraPIPState)state error:(NSString *)error {
  AGORA_LOG(@"pipStateChanged: %ld, error: %@", (long)state, error);

  NSDictionary *arguments = [[NSDictionary alloc]
      initWithObjectsAndKeys:[NSNumber numberWithLong:(long)state], @"state",
                             error, @"error", nil];
  [self.channel invokeMethod:@"pipStateChanged" arguments:arguments];
}

- (UIView *)findNativeView:(uint64_t)viewId {
  __block UIView *view;
  [self.nativeViews
      enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ((uint64_t)obj == viewId) {
          view = obj;
          *stop = YES;
        }
      }];
  return view;
}

- (void)applyContentViewLayout:(NSDictionary *)contentViewLayout
                        toView:(UIView *)view {
  if (!contentViewLayout || !view) {
    return;
  }

  // Get actual subview count
  NSArray *subviews = view.subviews;
  NSInteger subviewCount = subviews.count;
  if (subviewCount == 0) {
    return;
  }

  NSNumber *padding = contentViewLayout[@"padding"];
  NSNumber *spacing = contentViewLayout[@"spacing"];
  NSNumber *row = contentViewLayout[@"row"];
  NSNumber *column = contentViewLayout[@"column"];

  // Validate row and column values
  NSInteger actualRow = row ? [row integerValue] : 0;
  NSInteger actualColumn = column ? [column integerValue] : 0;

  // Rule 3: Ignore negative values
  if (actualRow < 0)
    actualRow = 0;
  if (actualColumn < 0)
    actualColumn = 0;

  // Rule 1: If row is not set or 0, calculate based on column and subview count
  if (actualRow == 0) {
    if (actualColumn > 0) {
      actualRow = (subviewCount + actualColumn - 1) / actualColumn;
    } else {
      // If both row and column are not set, use a default layout
      actualRow = 1;
      actualColumn = subviewCount;
    }
  }

  // Rule 2: Column is just a reference, adjust if needed
  if (actualColumn == 0) {
    if (actualRow > subviewCount) {
      actualColumn = 1;
    } else {
      actualColumn = (subviewCount + actualRow - 1) / actualRow;
    }
  }

  // Rule 4: If actualRow * actualColumn is less than subviewCount, adjust
  // actualRow and actualColumn
  if (actualRow * actualColumn < subviewCount) {
    actualColumn = (subviewCount + actualRow - 1) / actualRow;
  }

  // Remove existing constraints
  [view removeConstraints:view.constraints];
  for (UIView *subview in subviews) {
    // Only remove constraints between subview and parent view
    NSArray *subviewConstraints = [subview.constraints copy];
    for (NSLayoutConstraint *constraint in subviewConstraints) {
      if ((constraint.firstItem == subview && constraint.secondItem == view) ||
          (constraint.firstItem == view && constraint.secondItem == subview)) {
        [subview removeConstraint:constraint];
      }
    }
    subview.translatesAutoresizingMaskIntoConstraints = NO;
  }

  // Apply padding
  CGFloat paddingValue = padding ? [padding doubleValue] : 0;
  CGFloat spacingValue = spacing ? [spacing doubleValue] : 0;

  // Create constraints for each subview
  for (NSInteger i = 0; i < subviewCount; i++) {
    UIView *subview = subviews[i];
    NSInteger currentRow = i / actualColumn;
    NSInteger currentColumn = i % actualColumn;

    // Width constraint - equal width for all subviews in the same column
    if (currentColumn == 0) {
      // First column - set width based on container width
      [view addConstraint:[NSLayoutConstraint
                              constraintWithItem:subview
                                       attribute:NSLayoutAttributeWidth
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:view
                                       attribute:NSLayoutAttributeWidth
                                      multiplier:1.0 / actualColumn
                                        constant:-(spacingValue *
                                                       (actualColumn - 1) +
                                                   paddingValue * 2) /
                                                 actualColumn]];
    } else {
      // Other columns - equal to first column
      [view addConstraint:[NSLayoutConstraint
                              constraintWithItem:subview
                                       attribute:NSLayoutAttributeWidth
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:subviews[i - currentColumn]
                                       attribute:NSLayoutAttributeWidth
                                      multiplier:1.0
                                        constant:0.0]];
    }

    // Height constraint - equal height for all rows, regardless of whether they
    // have subviews
    [view
        addConstraint:[NSLayoutConstraint
                          constraintWithItem:subview
                                   attribute:NSLayoutAttributeHeight
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:view
                                   attribute:NSLayoutAttributeHeight
                                  multiplier:1.0 / actualRow
                                    constant:-(spacingValue * (actualRow - 1) +
                                               paddingValue * 2) /
                                             actualRow]];

    // Position constraints
    if (currentColumn == 0) {
      // First column - leading edge
      [view addConstraint:[NSLayoutConstraint
                              constraintWithItem:subview
                                       attribute:NSLayoutAttributeLeading
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:view
                                       attribute:NSLayoutAttributeLeading
                                      multiplier:1.0
                                        constant:paddingValue]];
    } else {
      // Other columns - spacing from previous view
      [view addConstraint:[NSLayoutConstraint
                              constraintWithItem:subview
                                       attribute:NSLayoutAttributeLeading
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:subviews[i - 1]
                                       attribute:NSLayoutAttributeTrailing
                                      multiplier:1.0
                                        constant:spacingValue]];
    }

    if (currentRow == 0) {
      // First row - top edge
      [view addConstraint:[NSLayoutConstraint
                              constraintWithItem:subview
                                       attribute:NSLayoutAttributeTop
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:view
                                       attribute:NSLayoutAttributeTop
                                      multiplier:1.0
                                        constant:paddingValue]];
    } else {
      // Other rows - spacing from row above
      [view addConstraint:[NSLayoutConstraint
                              constraintWithItem:subview
                                       attribute:NSLayoutAttributeTop
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:subviews[i - actualColumn]
                                       attribute:NSLayoutAttributeBottom
                                      multiplier:1.0
                                        constant:spacingValue]];
    }

    // Last column - trailing edge
    if (currentColumn == actualColumn - 1) {
      [view addConstraint:[NSLayoutConstraint
                              constraintWithItem:subview
                                       attribute:NSLayoutAttributeTrailing
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:view
                                       attribute:NSLayoutAttributeTrailing
                                      multiplier:1.0
                                        constant:-paddingValue]];
    }

    // Last row - bottom edge
    if (currentRow == actualRow - 1) {
      [view addConstraint:[NSLayoutConstraint
                              constraintWithItem:subview
                                       attribute:NSLayoutAttributeBottom
                                       relatedBy:NSLayoutRelationEqual
                                          toItem:view
                                       attribute:NSLayoutAttributeBottom
                                      multiplier:1.0
                                        constant:-paddingValue]];
    }
  }
}
@end
