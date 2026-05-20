#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

%hook WKNavigationAction
- (WKNavigationActionPolicy)navigationActionPolicy
{
    NSString *targetURL = self.request.URL.absoluteString;
    if ([targetURL containsString:@"taobao.com"] ||
        [targetURL containsString:@"tmall.com"] ||
        [targetURL containsString:@"tb.cn"])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSURL *realUrl = [NSURL URLWithString:targetURL];
            NSString *schemeStr = [NSString stringWithFormat:@"taobao://%@",targetURL];
            NSURL *tbScheme = [NSURL URLWithString:schemeStr];
            if ([[UIApplication sharedApplication] canOpenURL:tbScheme])
            {
                [[UIApplication sharedApplication] openURL:tbScheme options:@{} completionHandler:nil];
            }
            else
            {
                [[UIApplication sharedApplication] openURL:realUrl options:@{} completionHandler:nil];
            }
        });
        return WKNavigationActionPolicyCancel;
    }
    return %orig;
}
%end

%hook UIApplication
- (BOOL)openURL:(NSURL *)url
{
    NSString *urlStr = url.absoluteString;
    if ([urlStr containsString:@"taobao.com"] || [urlStr containsString:@"tmall.com"])
    {
        NSURL *jumpUrl = [NSURL URLWithString:[@"taobao://" stringByAppendingString:urlStr]];
        [[UIApplication sharedApplication] openURL:jumpUrl options:@{} completionHandler:nil];
        return YES;
    }
    return %orig;
}
%end
