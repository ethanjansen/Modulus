#import <Preferences/PSListController.h>
#import "MDLArrayCell.h"

@interface MDLIndividualsListController : PSListController
{
  BOOL _editButtonStatus;
  NSMutableArray *_buttonArray;
}

@property (nonatomic, weak, readonly) MDLArrayCell *currentCustomCell;

- (void)setupVars:(NSNotification *)notification;
- (void)editButtonClicked:(UIBarButtonItem *)button;
- (void)addButtonClicked:(UIBarButtonItem *)button;

@end
