/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

#import "CDVInAppBrowserOptions.h"

@implementation CDVInAppBrowserOptions

- (id)init
{
    if (self = [super init]) {
        // default values
        self.location = YES;
        self.toolbar = YES;
        self.closebuttoncaption = nil;
        self.toolbarposition = @"bottom";
        self.cleardata = NO;
        self.clearcache = NO;
        self.clearsessioncache = NO;
        self.hidespinner = NO;

        self.enableviewportscale = NO;
        self.mediaplaybackrequiresuseraction = NO;
        self.allowinlinemediaplayback = NO;
        self.hidden = NO;
        self.disallowoverscroll = NO;
        self.hidenavigationbuttons = NO;
        self.closebuttoncolor = nil;
        self.lefttoright = false;
        self.toolbarcolor = nil;
        self.toolbartranslucent = YES;
        self.beforeload = @"";
        self.userAgent = @"";


    }

    return self;
}

+ (CDVInAppBrowserOptions*)parseOptions:(NSString*)options
{
    CDVInAppBrowserOptions* obj = [[CDVInAppBrowserOptions alloc] init];

    NSArray* pairs = [options componentsSeparatedByString:@","];

    for (NSString* pair in pairs) {
        NSArray* keyvalue = [pair componentsSeparatedByString:@"="];
        if ([keyvalue count] == 2) {
            NSString* key = [[keyvalue objectAtIndex:0] lowercaseString];
            NSString* value = [keyvalue objectAtIndex:1]
            if ([key isEqualToString:@"useragent"]) {
                obj.userAgent = value;
            } else {
                if ([obj respondsToSelector:NSSelectorFromString(key)]) {
                    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
                    [numberFormatter setAllowsFloats:YES];
                    BOOL isNumber = [numberFormatter numberFromString:value] != nil;
                    BOOL isBoolean = [value isEqualToString:@"yes"] || [value isEqualToString:@"no"];
                    if (isNumber) {
                        [obj setValue:[numberFormatter numberFromString:value] forKey:key];
                    } else if (isBoolean) {
                        [obj setValue:[NSNumber numberWithBool:[value isEqualToString:@"yes"]] forKey:key];
                    } else {
                        [obj setValue:value forKey:key];
                    }
                }
            }
        }
    }

    return obj;
}

@end
