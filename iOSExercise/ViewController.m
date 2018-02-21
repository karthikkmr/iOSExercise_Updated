//
//  ViewController.m
//  iOSExercise
//
//  Created by Admin on 11/02/18.
//  Copyright © 2018 Admin. All rights reserved.
//

#import "ViewController.h"
#import "CustomTableViewCell.h"
#import "SVProgressHUD.h"

NSString *const webserviceAPI = @"https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json";

@interface ViewController ()

@end

@implementation ViewController

@synthesize itemsArray = _itemsArray;
@synthesize dataTable = _dataTable;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [SVProgressHUD show];
    screenRect = [[UIScreen mainScreen] bounds];
    screenWidth = screenRect.size.width;
    screenHeight = screenRect.size.height;
    self.itemsArray = [[NSMutableArray alloc] init];
    utilities = [[Utilities alloc] init];
    myHandler = [[NetworkHandler alloc] init];
    myHandler.delegate = self;
    [self setupView];
}
#pragma mark - setupViews
- (void)setupView{
        self.view.backgroundColor = [UIColor whiteColor];
        self.navigationController.navigationBar.topItem.title = @"iOS Exercise";
   
    // TableView Allocation
    UITableView *tableview = [UITableView new];
    [tableview setTranslatesAutoresizingMaskIntoConstraints:NO];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.bounces = true;
    tableview.allowsSelection = false;
    [self.view addSubview:tableview];
   
    tableview.rowHeight = UITableViewAutomaticDimension;
    tableview.estimatedRowHeight = 400;
    
    [tableview registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"MyIdentifier"];
    [tableview setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    self.dataTable = tableview;
   
    refreshControl = [[UIRefreshControl alloc]init];
    [self.dataTable addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    [self setUpConstraints];
}
#pragma mark - setUpConstraints
- (void)setUpConstraints{
    [self.dataTable.leadingAnchor constraintEqualToAnchor:self.dataTable.superview.leadingAnchor constant:0.].active = YES;
    [self.dataTable.trailingAnchor constraintEqualToAnchor:self.dataTable.superview.trailingAnchor constant:0.].active = YES;
    [self.dataTable.topAnchor constraintEqualToAnchor:self.dataTable.superview.topAnchor constant:0].active = YES;
    [self.dataTable.bottomAnchor constraintEqualToAnchor:self.dataTable.superview.bottomAnchor constant:0].active = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    // Check Internet Connection and load data
    [self connectionCheck];
}

-(void)connectionCheck{
   
    self.checkConnection = [utilities connectedToNetwork];
    if (!self.checkConnection) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"No internet"
                                                                       message: @"No internet connection found. Please try again later"
                                                                preferredStyle: UIAlertControllerStyleAlert];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle: @"OK"
                                                           style: UIAlertActionStyleDefault
                                                         handler: nil];
        [alert addAction: okAction];
        [self presentViewController: alert animated: YES completion: NULL];
    }
    else{
        [myHandler didFinishWebService:webserviceAPI];
    }
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if ([self.dataTable respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.dataTable setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.dataTable respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.dataTable setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)refreshTable {
    //TODO: refresh your data
    [refreshControl endRefreshing];
    [self connectionCheck];
}
#pragma Tableview Delegate and Datasource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CustomTableViewCell *cell = (CustomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kPlaceListCell];
    if (cell == nil)
    {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kPlaceListCell];
    }
    cell.backgroundColor = [UIColor whiteColor];
    cell.tag = indexPath.row;
    cell.thumbImg.image = nil;
    
    // Load details from Array
    NSDictionary *dataDictionary = [self.itemsArray objectAtIndex:indexPath.row];
    NSString *headingStr = [dataDictionary valueForKey:@"title"];
    NSString *descriptionStr = [dataDictionary valueForKey:@"description"];
    NSString *imageStr = [dataDictionary valueForKey:@"imageHref"];
    
    // Heading Label
    if (!([headingStr isEqual:[NSNull null]] || headingStr == nil )) {
        cell.headingLbl.text = headingStr;
    }else{
        cell.headingLbl.text = @"";
    }
   
    // Description Label
    if (!([descriptionStr isEqual:[NSNull null]] || descriptionStr == nil )) {
        cell.descriptionLbl.text = descriptionStr;
        cell.vehicleImageViewBottomConstraint.active = NO;
    }else{
        cell.vehicleImageViewBottomConstraint.active = YES;
        cell.descriptionLbl.text = @"";
    }
    
    // Thumb image
    if (!([imageStr isKindOfClass:[NSNull class]] || imageStr == nil )) {
        NSURL *imgURL = [NSURL URLWithString:imageStr];
//        NSLog(@"%@",imgURL);
        dispatch_queue_t backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0);
        dispatch_async(backgroundQueue, ^{
            UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:imgURL]];
            // only update UI on the main thread
            dispatch_async(dispatch_get_main_queue(), ^{
                if(cell.tag == indexPath.row) {
                    cell.thumbImg.image = image;
                }
            });
        });
    }else{
//        cell.thumbImg.image = [UIImage imageNamed:@"placeholder"];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{ 
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

// NetworkHandler DidFinish Delegate Method
-(void)didFinishDetails:(NSDictionary*) resultDictionary{
    //UINavigationBar Title Text chages Here
    self.titleString = [resultDictionary valueForKey:@"title"];
    self.navigationController.navigationBar.topItem.title = self.titleString;
    self.itemsArray = [resultDictionary valueForKey:@"rows"];
    // UI update should be done on main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.dataTable reloadData];
        [SVProgressHUD dismiss];
    });
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    // do before rotation
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    // do after rotation
}

-(void)tableItemcount{
    self.rowsCount = self.itemsArray.count;
}
-(void)apiURlMethod{
    self.webAPIURl = webserviceAPI;
}
-(void)webDataMethod{
    self.titleString = @"About Canada";
}

@end
