//
//  CustomTableViewCell.m
//  iOSExercise
//
//  Created by Admin on 11/02/18.
//  Copyright © 2018 Admin. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell
@synthesize headingLbl = _headingLbl;
@synthesize thumbImg   = _thumbImg;
@synthesize descriptionLbl = _descriptionLbl;
@synthesize vehicleImageViewBottomConstraint = _vehicleImageViewBottomConstraint;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        reuseID = reuseIdentifier;
        [self setupViews];
    }
    return self;
}

#pragma mark - setupCellviews

- (void)setupViews
{
    {
        UIImageView * imageView = [UIImageView new];
        
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [imageView setImage:[UIImage imageNamed:@"placeholder"]];
        
//        imageView.contentMode = UIViewContentModeCenter;
        
        imageView.clipsToBounds = YES;
        
        [self.contentView addSubview:imageView];
        
        self.thumbImg = imageView;
    }
    {
        UILabel * label = [UILabel new];
        
        label.translatesAutoresizingMaskIntoConstraints = NO;
        
        label.backgroundColor = [UIColor clearColor];
        
        [label setTextColor:[UIColor blackColor]];
       
        [label setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:18.0f]];
       
        [label setTranslatesAutoresizingMaskIntoConstraints:NO];
       
        [self.contentView addSubview:label];
        
        self.headingLbl = label;
        
    }
    {
        UILabel * label = [UILabel new];
        
        label.translatesAutoresizingMaskIntoConstraints = NO;
        
        label.backgroundColor = [UIColor clearColor];
        
        [label setTextColor:[UIColor blackColor]];
       
        [label setFont:[UIFont fontWithName:@"HelveticaNeue" size:18.0f]];
       
        [label setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        label.numberOfLines=0;
        
        [self.contentView addSubview:label];
        
        self.descriptionLbl = label;
        
    }

    
    [self setupConstraints];
    
}
#pragma mark - setupCellviewConstraints

- (void)setupConstraints
{
  
    [self.thumbImg.leadingAnchor constraintEqualToAnchor:self.thumbImg.superview.leadingAnchor constant:20].active = YES;
        
    [self.thumbImg.topAnchor constraintEqualToAnchor:self.thumbImg.superview.topAnchor constant:10].active = YES;
        
    //[self.thumbImg.bottomAnchor constraintEqualToAnchor:self.descriptionLbl.bottomAnchor constant:0].active = YES;
    
    self.vehicleImageViewBottomConstraint = [self.thumbImg.bottomAnchor constraintEqualToAnchor:self.thumbImg.superview.bottomAnchor constant: -10.0f];
    
    self.vehicleImageViewBottomConstraint.priority = 100;
    
    [self.thumbImg.heightAnchor constraintEqualToConstant:60.].active = YES;
        
    [self.thumbImg.widthAnchor constraintEqualToConstant:60.].active = YES;
    
   
    [self.headingLbl.leadingAnchor constraintEqualToAnchor:self.thumbImg.trailingAnchor constant:20].active = YES;
    
    [self.headingLbl.topAnchor constraintEqualToAnchor:self.thumbImg.topAnchor constant:0].active = YES;
    
    [self.headingLbl.trailingAnchor constraintEqualToAnchor:self.headingLbl.superview.trailingAnchor constant:-20].active = YES;
    
    
    [self.descriptionLbl.leadingAnchor constraintEqualToAnchor:self.thumbImg.trailingAnchor constant:20].active = YES;
    
    [self.descriptionLbl.topAnchor constraintEqualToAnchor:self.headingLbl.bottomAnchor constant:10].active = YES;
    
    [self.descriptionLbl.trailingAnchor constraintEqualToAnchor:self.descriptionLbl.superview.trailingAnchor constant:-20].active = YES;
    
     [self.descriptionLbl.bottomAnchor constraintEqualToAnchor:self.descriptionLbl.superview.bottomAnchor constant:-10].active = YES;
}
#pragma mark - update layout
- (void) updateConstraints {
    
    if (!self.hasSetupConstraints) {
        
        [self setupConstraints];
        
        [self setHasSetupConstraints: YES];
    }
    
    [super updateConstraints];
}

@end
