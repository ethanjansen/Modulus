#import "MDLArrayCell.h"
#import "MDLIndividualsButtonsListController.h"

#import "EthanLogs.h"

@implementation MDLArrayCell

- (id)initWithSpecifier:(PSSpecifier *)specifier
{
  self = [super initWithStyle:UITableViewCellStyleDefault
              reuseIdentifier:@"Cell"
                    specifier:specifier];

  if (self) {
    CGRect tableFrame = [self frame];
    tableFrame.size.height = [self preferredHeightForWidth:(CGFloat)tableFrame.size.width];

    _tableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];

    _tableView.rowHeight = 44;
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;

    _tableView.dataSource = self;
    _tableView.delegate = self;

    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableCell"];

    [_tableView reloadData];
    [self addSubview:_tableView];

  }
  return self;
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
  cell.showsReorderControl = YES;

  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [EthanLogs logWithString:@"Button pressed!\n"];
  //[[MDLIndividualsButtonsListController alloc] init];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
  return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
  return YES;
}

- (void)moveRowAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath
{
  id movedObject = [self array][indexPath.row];
  [[self array] removeObjectAtIndex:indexPath.row];
  [[self array] insertObject:movedObject atIndex:newIndexPath.row];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
  [EthanLogs logWithString:[NSString stringWithFormat:@"Deleting row: %ld\n", (long)indexPath.row]];
  [[self array] removeObjectAtIndex:indexPath.row];
  [tableView beginUpdates];
  [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
  [tableView endUpdates];
}

- (CGFloat)preferredHeightForWidth:(CGFloat)width {
  return [[self array] count] * 44.0;
}
@end
