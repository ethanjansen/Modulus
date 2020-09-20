#import "MDLIndividualsListController.h"
#import <Preferences/PSSpecifier.h>

@implementation MDLIndividualsListController

- (NSArray *)specifiers
{
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Individuals" target:self];
	}
	[(UINavigationItem *)self.navigationItem setTitle:@"Individual Modules"];
	UIBarButtonItem *editButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editButtonClicked:)];
	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Add" style:UIBarButtonItemStylePlain target:self action:@selector(addButtonClicked:)];
	_buttonArray = [[NSMutableArray alloc] initWithArray:@[editButton, addButton]];
	[self.navigationItem setRightBarButtonItems:_buttonArray];

	return _specifiers;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	[self setupVars:nil];

	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setupVars:) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	[self reload];
}

- (void)setupVars:(NSNotification *)notification
{
	_currentCustomCell = [MDLArrayCell returnCurrentPointer];
	_editButtonStatus = [self.currentCustomCell editingState];
	[_currentCustomCell setRootNavigationController:self.navigationController];
}

- (void)editButtonClicked:(UIBarButtonItem *)button
{
	_editButtonStatus = !_editButtonStatus;
	[self.currentCustomCell toggleEditingState:_editButtonStatus];
	button.title = (_editButtonStatus) ? @"Done" : @"Edit";
}

- (void)addButtonClicked:(UIBarButtonItem *)button
{
	[self.currentCustomCell addRow];
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
