//
//  ActivityTableViewCell.m
//  I'm In
//
//  Created by Sam Wong on 17/11/2014.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "ActivityTableViewCell.h"

@interface ActivityTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@end

@implementation ActivityTableViewCell

- (void)awakeFromNib {
    // Initialization code
//    self.innerView.layer.cornerRadius = 15;
//    self.innerView.clipsToBounds = true;
    
    if (_activity != nil) {
        _eventId = _activity.eventId;
        _dateLabel.text = _activity.eventTime;
        _descriptionLabel.text = _activity.eventDescription;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
