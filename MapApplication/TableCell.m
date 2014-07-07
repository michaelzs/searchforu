//
//  TableCell.m
//  MapApplication
//
//  Created by Zhan Shu on 2/16/14.
//  Copyright (c) 2014 COMS. All rights reserved.
//

#import "TableCell.h"

@implementation TableCell
@synthesize thumbnailImageView=_thumbnailImageView;
@synthesize nameLabel=_nameLabel;
@synthesize vicinityLabel=_vicinityLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
