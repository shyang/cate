#import <CoreTelephony/CTCall.h>
#import <SpringBoard/SpringBoard.h>

extern "C" {

void CTCallDisconnect(CTCall *call);
NSString *CTCallCopyAddress(void *, CTCall *call);

}


%hook CTCallCenter
- (id)description { %log; id r = %orig; NSLog(@" = %@", r); return r; }
- (void)broadcastCallStateChangesIfNeededWithFailureLogMessage:(id)arg1 { %log; %orig; }

- (void)handleNotificationFromConnection:(void *)arg1 ofType:(id)arg2 withInfo:(NSDictionary *)info {
    %log;

    CTCall *call = [info objectForKey:@"kCTCall"];
    NSLog(@"CTCall class %@", [CTCall class]);
    NSString *caller = CTCallCopyAddress(NULL, call);
    NSLog(@"caller is %@", caller);
    if ([caller isEqualToString:@"13918205254"]) {
        CTCallDisconnect(call);
    }

    [caller release];
    %orig;
}
- (void)setCurrentCalls:(NSSet *)currentCalls { %log; %orig; }
- (NSSet *)currentCalls {
    %log;
    NSSet * r = %orig;
    NSLog(@" = %@", r);
    return r;
}
- (BOOL)calculateCallStateChanges:(id)arg1 { %log; BOOL r = %orig; NSLog(@" = %d", r); return r; }
- (BOOL)getCurrentCallSetFromServer:(id)arg1 { %log; BOOL r = %orig; NSLog(@" = %d", r); return r; }
- (void)setCallEventHandler:(id )callEventHandler { %log; %orig; }
- (id )callEventHandler { %log; id  r = %orig; NSLog(@" = %@", r); return r; }
- (void)dealloc { %log; %orig; }
- (id)init { %log; id r = %orig; NSLog(@" = %@", r); return r; }
- (void)cleanUpServerConnection { %log; %orig; }
- (BOOL)setUpServerConnection { %log; BOOL r = %orig; NSLog(@" = %d", r); return r; }
%end

%hook SpringBoard

-(void)applicationDidFinishLaunching:(id)application {
    %log;
    %orig;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Welcome" message:@"Welcome to your iPhone Brandon!" delegate:nil cancelButtonTitle:@"Thanks" otherButtonTitles:nil];
    [alert show];
    [alert release];
}

%end

