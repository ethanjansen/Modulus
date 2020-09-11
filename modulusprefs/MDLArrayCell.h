#import <Preferences/PSTableCell.h>
#import <Preferences/PSSpecifier.h>

@protocol PreferencesTableCustomView
- (id)initWithSpecifier:(PSSpecifier *)specifier;
- (CGFloat)preferredHeightForWidth:(CGFloat)width;
@end

@interface MDLArrayCell : PSTableCell <PreferencesTableCustomView, UITableViewDataSource, UITableViewDelegate>
{
  UITableView *_tableView;
}

@property (nonatomic) NSMutableArray *array;

@end
