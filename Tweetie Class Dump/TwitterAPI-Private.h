/*
 *     Generated by class-dump 3.3.3 (64 bit).
 *
 *     class-dump is Copyright (C) 1997-1998, 2000-2001, 2004-2010 by Steve Nygard.
 */

#import "TwitterAPI.h"

@interface TwitterAPI (Private)
- (void)request:(id)arg1 method:(id)arg2 body:(id)arg3 callback:(id)arg4;
- (void)POST:(id)arg1 body:(id)arg2 callback:(id)arg3;
- (void)GET:(id)arg1 callback:(id)arg2;
- (void)requestResponse:(id)arg1 info:(id)arg2;
- (void)parseTwitterError:(id)arg1 info:(id)arg2;
- (void)invokeCallback:(id)arg1;
- (id)statusesResponseCallback;
- (id)statusResponseCallback;
- (void)statusResponse:(id)arg1 info:(id)arg2;
- (void)statusesResponse:(id)arg1 info:(id)arg2;
- (id)usersResponseCallback;
- (id)userResponseCallback;
- (void)userResponse:(id)arg1 info:(id)arg2;
- (void)usersResponse:(id)arg1 info:(id)arg2;
@end

