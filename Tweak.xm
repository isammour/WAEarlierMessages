
	#import <Social/Social.h>
	#import <UIKit/UIKit.h>
	@interface WAChatButton:UIButton
@end
	@interface WAConversationHeaderView : UIView 
	@end
	@interface WAViewController : UIViewController
	@end
	@interface WAChatBackgroundViewController : WAViewController
	@end
	@interface ChatTableView : UITableView
@end
	@interface WAChatBaseViewController : WAChatBackgroundViewController
	@end
	
	@interface ChatViewController : WAChatBaseViewController
	@property(retain, nonatomic) WAConversationHeaderView* headerView;
	@property(retain, nonatomic) UIView* viewChatButtons;
	@property(retain, nonatomic) WAChatButton* buttonLoadMessages;
	
@property(retain, nonatomic) ChatTableView* tableViewMessages;

 @end	    
#define kPreferencesPath @"/User/Library/Preferences/com.sammour.ISLoader.plist"
#define kPreferencesChanged "com.sammour.ISLoader.preferences-changed"
#define kTapConfirmation @"tapConfirmation"
static BOOL tapConfirmation;
#define kTapConfirmation1 @"tapConfirmation1"
static BOOL tapConfirmation1;
#define wechatz @"wechat"
static BOOL wechat ;
static void ISLoaderInitPrefs() {
    NSDictionary *ISLoadersettings = [NSDictionary dictionaryWithContentsOfFile:kPreferencesPath];
    NSNumber *ISLoaderEnableOptionKey1 = ISLoadersettings[kTapConfirmation];
    tapConfirmation = ISLoaderEnableOptionKey1 ? [ISLoaderEnableOptionKey1 boolValue] : 1;
	NSNumber *ISLoaderEnableOptionKey2 = ISLoadersettings[kTapConfirmation1];
    tapConfirmation1 = ISLoaderEnableOptionKey2 ? [ISLoaderEnableOptionKey2 boolValue] : 1;
	NSNumber *ISLoaderEnableOptionKey3 = ISLoadersettings[wechatz];
    wechat = ISLoaderEnableOptionKey3 ? [ISLoaderEnableOptionKey3 boolValue] : 1;
}
%hook ChatViewController


int i=0;

-(id)loadMessagesFromOffset:(unsigned)offset count:(unsigned)count{

   NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.sammour.ISLoader.plist"];

       
	int target = [[prefs objectForKey:@"Slider"] intValue];

if(tapConfirmation){
if(offset>10)
{
	count = target;	
}
}
	return %orig;

}
%end
%hook CKConversation
-(void)loadMoreMessages{
   NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.sammour.ISLoader.plist"];

       
	float target = [[prefs objectForKey:@"Slider1"] floatValue];

if(tapConfirmation1){
UIAlertView *alert = [[UIAlertView alloc]  init];
	[alert setMessage:@"Load Earlier Messages ? "];
	[alert setTitle:@"ISLoader"];
	[alert setDelegate:self];
	[alert addButtonWithTitle:@"All"];
	[alert addButtonWithTitle:@"Once"];
	[alert show];
	[alert release];
	[alert showWithCompletion:^(UIAlertView *alertView, NSInteger buttonIndex) {
	    if (buttonIndex == 0)
	    {
		while(i<target){%orig;i++;}
		 i=0;
	    }
	    else if (buttonIndex == 1)
	    {
	       %orig;
	    }
	}];
}
else{
%orig;}
}
%end
%hook BottleSessionViewController
-(void)BottleNeedReload{}
%end


%hook BaseMsgContentLogicController




-(unsigned long)getMsgCountToLoad
{
	
	if(wechat)
	{
	NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.sammour.ISLoader.plist"];

       
	float target = [[prefs objectForKey:@"Sliderwe"] floatValue];
	
	return target;	
	
	
	}
	else{
		return %orig;

	}
	
}

%end



%hook ChatViewController


-(void)viewDidLoad
{
	%orig;
/*
UIButton *myButton = [[UIButton alloc] initWithFrame:CGRectMake(170,5, 30, 20)];
[myButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
[myButton setTitle:[NSString stringWithFormat:@"%C", 0x2764] forState:UIControlStateNormal];

[myButton addTarget:self action:@selector(btnPressed) forControlEvents:UIControlEventTouchUpInside];
myButton.userInteractionEnabled =YES;
self.headerView.userInteractionEnabled =YES;

[self.headerView addSubview:myButton];
	

*/

}



%new 


	-(void)btnPressed{
		
		
	 SLComposeViewController *tweetSheetOBJ = [SLComposeViewController
					       composeViewControllerForServiceType:SLServiceTypeTwitter];
	[tweetSheetOBJ setInitialText:@"I am using 'WA Earlier Messages' by 'Ibrahim Sammour' to load all whatsapp messages at once"];
      [self presentViewController:tweetSheetOBJ animated:YES completion:nil];
    
}



%end

%ctor{
CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)ISLoaderInitPrefs, CFSTR(kPreferencesChanged), NULL, CFNotificationSuspensionBehaviorCoalesce);
   

	ISLoaderInitPrefs();
}
