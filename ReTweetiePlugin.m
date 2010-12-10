//
//  ReTweetiePlugin.m
//  ReTweetie
//
//  Created by Nick Paulson on 12/9/10.
//  Copyright 2010 Linebreak. All rights reserved.
//

#import "ReTweetiePlugin.h"
#import "SynthesizeSingleton.h"
#import "TwitterStatus.h"
#import "TweetieStatusTableViewCell.h"
#import "TweetieStatusListViewController.h"
#import "JRSwizzle.h"
#import "TwitterAccount.h"
#import "TweetieAccountTabsView.h"
#import "TwitterAPI.h"
#import "TwitterAPI-Private.h"
#import "ABCallback.h"
#import <objc/runtime.h>

static void NPCellRepost(id self, SEL _cmd, TweetieStatusTableViewCell *cell, TwitterStatus *status)
{
	NSArray *potentialSubviews = [[[cell window] contentView] subviews];
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"class == %@", NSClassFromString(@"TweetieAccountTabsView")];
    NSArray *result = [potentialSubviews filteredArrayUsingPredicate:predicate];
	if ([result count] > 0) {
		TweetieAccountTabsView *tabView = [result objectAtIndex:0];
		TwitterAccount *account = [tabView selectedAccount];
		if (account != nil) {
			ABCallback *callback = [NSClassFromString(@"ABCallback") callbackWithTarget:[ReTweetiePlugin sharedInstance] selector:@selector(apiCallback:) info:nil];
			TwitterAPI *api = [[NSClassFromString(@"TwitterAPI") alloc] initWithAccount:account callback:callback];
			[api POST:[NSString stringWithFormat:@"statuses/retweet/%@.xml", status.statusID] body:nil callback:callback];
			
		}
	}
}

@implementation ReTweetiePlugin

SYNTHESIZE_SINGLETON_FOR_CLASS(ReTweetiePlugin, sharedInstance);

+ (void)load {
	[ReTweetiePlugin sharedInstance];

	Method repostStatus = class_getInstanceMethod(NSClassFromString(@"TweetieStatusListViewController"), @selector(tweetieStatusCell:repostStatus:));
    const char *types = method_getTypeEncoding(repostStatus);
	class_addMethod(NSClassFromString(@"TweetieStatusListViewController"), @selector(np_tweetieStatusCell:repostStatus:), (IMP)NPCellRepost, types);
	[NSClassFromString(@"TweetieStatusListViewController") jr_swizzleMethod:@selector(tweetieStatusCell:repostStatus:) withMethod:@selector(np_tweetieStatusCell:repostStatus:) error:nil];
	
}

- (id)init {
	if (self = [super init]) {
		
	}
	return self;
}

- (void)apiCallback:(id)info {
	
}

@end
