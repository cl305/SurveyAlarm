//
//  SurveyResults+CoreDataProperties.h
//  SurveyAlarm
//
//  Created by Cody Li on 7/13/16.
//  Copyright © 2016 Cody Li. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "SurveyResults.h"

NS_ASSUME_NONNULL_BEGIN

@interface SurveyResults (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *identifier;
@property (nullable, nonatomic, retain) NSString *answers;
@property (nullable, nonatomic, retain) NSDate *date;

@end

NS_ASSUME_NONNULL_END
