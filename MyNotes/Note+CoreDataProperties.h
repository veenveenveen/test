//
//  Note+CoreDataProperties.h
//  test
//
//  Created by 黄启明 on 2016/12/1.
//  Copyright © 2016年 huatengIOT. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Note+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Note (CoreDataProperties)

+ (NSFetchRequest<Note *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *details;
@property (nullable, nonatomic, copy) NSString *creatTime;
@property (nullable, nonatomic, copy) NSString *sectionName;
@property (nonatomic, assign) double intervalFlag;

@end

NS_ASSUME_NONNULL_END
