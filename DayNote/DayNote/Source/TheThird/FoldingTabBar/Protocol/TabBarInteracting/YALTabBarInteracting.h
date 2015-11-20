// For License please refer to LICENSE file in the root of YALAnimatingTabBarController project

#import <Foundation/Foundation.h>

@class YALFoldingTabBar;

@protocol YALTabBarInteracting <NSObject>

@optional

- (void)tabBarViewWillCollapse:(YALFoldingTabBar *)sender;
- (void)tabBarViewWillExpand;

- (void)tabBarViewDidCollapse;
- (void)tabBarViewDidExpand;

- (void)extraLeftItemDidPress;
- (void)extraRightItemDidPress;

@end
