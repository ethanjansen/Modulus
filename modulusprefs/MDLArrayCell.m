#import "MDLArrayCell.h"

#import "EthanLogs.h"

@implementation MDLArrayCell

- (id)initWithSpecifier:(PSSpecifier *)specifier
{
  self = [super initWithStyle:UITableViewCellStyleDefault
              reuseIdentifier:@"Cell"
                    specifier:specifier];

  if (self) {
    CGRect tableFrame = [self frame];
    [EthanLogs logWithString:[NSString stringWithFormat:@"orginal frame: %@\n", NSStringFromCGRect(tableFrame)]];
    tableFrame.size.height = [self preferredHeightForWidth:(CGFloat)tableFrame.size.width];

    _tableView = [[UITableView alloc] initWithFrame:tableFrame style:UITableViewStylePlain];

    _tableView.rowHeight = 44;

    _tableView.dataSource = self;
    _tableView.delegate = self;

    //_tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableCell"];

    [_tableView reloadData];
    [self addSubview:_tableView];

  }
  return self;
}

- (NSMutableArray *)array
{
  _array = [[NSMutableArray alloc] init];

  for (int i = 0; i < 3; i ++) {
    NSString *string = [NSString stringWithFormat:@"String: %d", i];
    [_array addObject:string];
  }
  return _array;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)Section
{
  //return [_array count];
  return 3;
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
  return cell;
}

- (CGFloat)preferredHeightForWidth:(CGFloat)width {
  return 132.f;
}
@end
