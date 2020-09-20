#import "MDLArrayCell.h"
#import "MDLIndividualsButtonsListController.h"

//Logging Class
#import "EthanLogs.h"

//static variables
static BOOL _editingState;
static NSString *_arrayType;
__weak static MDLArrayCell *_currentPointer;

@implementation MDLArrayCell

- (id)initWithSpecifier:(PSSpecifier *)specifier
{
  _editingState = NO;

  self = [super initWithStyle:UITableViewCellStyleDefault
              reuseIdentifier:@"Cell"
                    specifier:specifier];

  if (self) {
    self.clipsToBounds = YES;
    self.autoresizesSubviews = YES;

    CGRect tableFrame = [self frame];
    tableFrame.size.height = [self preferredHeightForWidth:(CGFloat)tableFrame.size.width];
    _tableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];

    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
    _tableView.rowHeight = 44;
    _tableView.scrollEnabled = NO;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.editing = _editingState;

    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableCell"];

    [_tableView reloadData];
    [self addSubview:_tableView];

    _currentPointer = self;
  }
  return self;
}

- (CGFloat)preferredHeightForWidth:(CGFloat)width
{
  return [[self array] count] * 44.0;
}

- (NSMutableArray *)array
{
  if (!_array) {
    _array = [[NSMutableArray alloc] init];

    for (int i = 0; i < 3; i ++) {
      NSString *string = [NSString stringWithFormat:@"String: %d", i];
      [_array addObject:string];
    }
  }
  return _array;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)Section
{
  return [[self array] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"tableCell";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

  if (!cell)
  {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  }
  cell.textLabel.text = [self array][indexPath.row];
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
  cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  //FIX THIS -- add ability to change type of view controller
  [EthanLogs logWithString:[NSString stringWithFormat:@"Button, %@ pressed at index path: %ld\n", self.array[indexPath.row], (long)indexPath.row]];
  PSListController *individualsButtons = [[MDLIndividualsButtonsListController alloc] init];
  [self pushController:individualsButtons];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
  return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath
{
  id movedObject = [self array][indexPath.row];
  [[self array] removeObjectAtIndex:indexPath.row];
  [[self array] insertObject:movedObject atIndex:newIndexPath.row];
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (editingStyle == UITableViewCellEditingStyleDelete) {
    [[self array] removeObjectAtIndex:indexPath.row];
    [tableView beginUpdates];
    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    [tableView endUpdates];
  }
}

- (void)addRow
{
  [_tableView beginUpdates];
  [self.array addObject:@"insert"];
  NSIndexPath *insertIndex = [NSIndexPath indexPathForRow:([self.array count] - 1) inSection:0];
  [_tableView insertRowsAtIndexPaths:@[insertIndex] withRowAnimation:UITableViewRowAnimationTop];
  [_tableView endUpdates];
  [self tableView:_tableView didSelectRowAtIndexPath:insertIndex];
}

- (void)pushController:(id)viewController
{
  if (_rootNavigationController) {
    [_rootNavigationController pushViewController:viewController animated:YES];
  }
}

- (void)setArrayType:(NSString *)arrayType
{
  _arrayType = arrayType;
}

- (BOOL)editingState
{
  return _editingState;
}

- (void)toggleEditingState:(BOOL)state
{
  _editingState = state;
  _tableView.editing = _editingState;
  [_tableView reloadData];
}

+ (MDLArrayCell *)returnCurrentPointer
{
  return _currentPointer;
}

- (void)dealloc
{
  [EthanLogs logWithString:@"deallocating arrayCell\n"];
}
@end
