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
@property (nonatomic, weak) UINavigationController *rootNavigationController;
//@property (nonatomic, readonly) BOOL editingState;

- (void)addRow;
- (void)setArrayType:(NSString *)arrayType;
- (BOOL)editingState;
- (void)toggleEditingState:(BOOL)state;
- (void)pushController:(id)viewController;
+ (MDLArrayCell *)returnCurrentPointer;

@end
