//
//  dianhuabenManager.m
//  testApp
//
//  Created by juge on 2017/10/31.
//  Copyright © 2017年 juge. All rights reserved.
//

#import "dianhuabenManager.h"
#import "dianhuabenModel.h"
#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>
#import "dianhuabenSectionModel.h"
#import <PinYin4Objc.h>

#define letterArray @[@"A", @"B", @"C", @"D", @"E", @"F", @"G", @"H", @"I", @"J", @"Q", @"L", @"M", @"N", @"O", @"P", @"Q", @"I", @"S", @"T", @"U", @"V", @"W", @"X", @"Y", @"Z"]
@interface dianhuabenManager()
@property (nonatomic, strong) dianhuabenBlock block;
@end

@implementation dianhuabenManager

+ (instancetype)shareManager {
    static dianhuabenManager *manager = nil;
    if (!manager) {
        manager = [[dianhuabenManager alloc] init];
    }
    return manager;
}

- (void)getDianhuabenContentiOS8WithBlock:(dianhuabenBlock)block {
    self.block = block;
    // 判断是否授权
    ABAuthorizationStatus authorizationStatus = ABAddressBookGetAuthorizationStatus();
    if (authorizationStatus == kABAuthorizationStatusNotDetermined) {
        [self requestAuthorizationAddressBook_iOS8];
        return;
    }
    [self getAddressBookiOS8];
}

- (void)getAddressBookiOS8 {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 1. 判读授权
        ABAuthorizationStatus authorizationStatus = ABAddressBookGetAuthorizationStatus();
        if (authorizationStatus != kABAuthorizationStatusAuthorized) {
            
            CGLog(@"没有授权");
            return;
        }
        
        // 2. 获取所有联系人
        ABAddressBookRef addressBookRef = ABAddressBookCreate();
        CFArrayRef arrayRef = ABAddressBookCopyArrayOfAllPeople(addressBookRef);
        long count = CFArrayGetCount(arrayRef);
        NSMutableArray *addressArray = [NSMutableArray array];
        for (int i = 0; i < count; i++) {
            //获取联系人对象的引用
            ABRecordRef people = CFArrayGetValueAtIndex(arrayRef, i);
            
            //获取当前联系人名字
            NSString *firstName=(__bridge NSString *)(ABRecordCopyValue(people, kABPersonFirstNameProperty));
            
            //获取当前联系人姓氏
            NSString *lastName=(__bridge NSString *)(ABRecordCopyValue(people, kABPersonLastNameProperty));
            CGLog(@"--------------------------------------------------");
            CGLog(@"firstName=%@, lastName=%@", firstName, lastName);
            
            
            //获取当前联系人的电话 数组
            NSMutableArray *phoneArray = [[NSMutableArray alloc]init];
            ABMultiValueRef phones = ABRecordCopyValue(people, kABPersonPhoneProperty);
            for (NSInteger j=0; j<ABMultiValueGetCount(phones); j++) {
                NSString *phone = (__bridge NSString *)(ABMultiValueCopyValueAtIndex(phones, j));
                CGLog(@"phone=%@", phone);
                [phoneArray addObject:phone];
            }
            
            //获取当前联系人的邮箱 注意是数组
            NSMutableArray *emailArray = [[NSMutableArray alloc]init];
            ABMultiValueRef emails= ABRecordCopyValue(people, kABPersonEmailProperty);
            for (NSInteger j=0; j<ABMultiValueGetCount(emails); j++) {
                NSString *email = (__bridge NSString *)(ABMultiValueCopyValueAtIndex(emails, j));
                CGLog(@"email=%@", email);
                [emailArray addObject:email];
                CGLog(@"当前联系人的邮箱:%@", email);
            }
            //获取当前联系人中间名
            NSString *middleName=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonMiddleNameProperty));
            CGLog(@"当前联系人中间名:%@", middleName);
            //获取当前联系人的名字前缀
            NSString *prefix=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonPrefixProperty));
            CGLog(@"当前联系人的名字前缀:%@", prefix);
            //获取当前联系人的名字后缀
            NSString *suffix=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonSuffixProperty));
            CGLog(@"当前联系人的名字后缀:%@", suffix);
            //获取当前联系人的昵称
            NSString *nickName=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonNicknameProperty));
            CGLog(@"当前联系人的昵称%@", nickName);
            //获取当前联系人的名字拼音
            NSString *firstNamePhoneic=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonFirstNamePhoneticProperty));
            CGLog(@"当前联系人的名字拼音:%@", firstNamePhoneic);
            //获取当前联系人的姓氏拼音
            NSString *lastNamePhoneic=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonLastNamePhoneticProperty));
            CGLog(@"当前联系人的姓氏拼音:%@", lastNamePhoneic);
            //获取当前联系人的中间名拼音
            NSString *middleNamePhoneic=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonMiddleNamePhoneticProperty));
            CGLog(@"当前联系人的中间名拼音:%@", middleNamePhoneic);
            //获取当前联系人的公司
            NSString *organization=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonOrganizationProperty));
            CGLog(@"当前联系人的公司:%@", organization);
            //获取当前联系人的职位
            NSString *job=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonJobTitleProperty));
            CGLog(@"当前联系人的职位:%@", job);
            //获取当前联系人的部门
            NSString *department=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonDepartmentProperty));
            CGLog(@"当前联系人的部门:%@", department);
            //获取当前联系人的生日
            NSDate *birthday=(__bridge NSDate*)(ABRecordCopyValue(people, kABPersonBirthdayProperty));
            CGLog(@"当前联系人的生日:%@", birthday);
            //获取当前联系人的备注
            NSString *notes=(__bridge NSString*)(ABRecordCopyValue(people, kABPersonNoteProperty));
            CGLog(@"当前联系人的备注:%@", notes);
            //获取创建当前联系人的时间 注意是NSDate
            NSDate *creatTime=(__bridge NSDate*)(ABRecordCopyValue(people, kABPersonCreationDateProperty));
            CGLog(@"创建当前联系人的时间:%@", creatTime);
            //获取最近修改当前联系人的时间
            NSDate *alterTime=(__bridge NSDate*)(ABRecordCopyValue(people, kABPersonModificationDateProperty));
            CGLog(@"最近修改当前联系人的时间:%@", alterTime);
            //获取地址
            ABMultiValueRef address = ABRecordCopyValue(people, kABPersonAddressProperty);
            for (int j=0; j<ABMultiValueGetCount(address); j++) {
                //地址类型
                NSString *type = (__bridge NSString *)(ABMultiValueCopyLabelAtIndex(address, j));
                CGLog(@"地址类型：%@", type);
                NSDictionary * tempDic = (__bridge NSDictionary *)(ABMultiValueCopyValueAtIndex(address, j));
                //地址字符串，可以按需求格式化
                NSString *adress = [NSString stringWithFormat:@"国家:%@\n省:%@\n市:%@\n街道:%@\n邮编:%@",[tempDic valueForKey:(NSString*)kABPersonAddressCountryKey],[tempDic valueForKey:(NSString*)kABPersonAddressStateKey],[tempDic valueForKey:(NSString*)kABPersonAddressCityKey],[tempDic valueForKey:(NSString*)kABPersonAddressStreetKey],[tempDic valueForKey:(NSString*)kABPersonAddressZIPKey]];
                CGLog(@"地址：%@",adress);
            }
            
            //获取当前联系人头像图片
            NSData *userImage=(__bridge NSData*)(ABPersonCopyImageData(people));
            CGLog(@"联系人头像：%@",userImage);

            //获取当前联系人纪念日
            NSMutableArray *dateArr = [[NSMutableArray alloc]init];
            ABMultiValueRef dates= ABRecordCopyValue(people, kABPersonDateProperty);
            for (NSInteger j=0; j<ABMultiValueGetCount(dates); j++) {
                //获取纪念日日期
                NSDate *data =(__bridge NSDate*)(ABMultiValueCopyValueAtIndex(dates, j));
                //获取纪念日名称
                NSString *str =(__bridge NSString*)(ABMultiValueCopyLabelAtIndex(dates, j));
                NSDictionary *tempDic = [NSDictionary dictionaryWithObject:data forKey:str];
                [dateArr addObject:tempDic];
            }
            
            dianhuabenModel *model = [[dianhuabenModel alloc] init];
            model.name = [NSString stringWithFormat:@"%@%@",lastName,firstName];
            model.mobileArr = phoneArray;
            model.pinyin = [NSString stringWithFormat:@"%@%@", lastNamePhoneic, firstNamePhoneic];
            [addressArray addObject:model];
        }
        [self fenleiWithNSArray:addressArray];

    });
}

- (void)requestAuthorizationAddressBook_iOS8 {
        // 请求授权
        ABAddressBookRef addressBookRef =  ABAddressBookCreate();
        ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
            if (granted) {  // 授权成功
                [self getAddressBookiOS8];
            } else {        // 授权失败
                CGLog(@"授权失败！");
            }
        });

}

- (void)getDianhuabenContentiOS9 {
//    CNAuthorizationStatus status = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
//    if (status == CNAuthorizationStatusAuthorized) {
//        CNContactStore *store = [[CNContactStore alloc] init];
//
//    } else if (status == CNAuthorizationStatusNotDetermined) {
//
//    }
}

- (void)getAddressBookiOS9 {
    
}

- (void)requestAuthorizationAddressBook_iOS9 {
    
}

- (void)fenleiWithNSArray:(NSArray *)array {
    NSMutableArray *sectionTitles = [NSMutableArray array];
    UILocalizedIndexedCollation *indexCollation = [UILocalizedIndexedCollation currentCollation];
    [sectionTitles addObjectsFromArray:[indexCollation sectionTitles]];
    NSInteger highSection = [sectionTitles count];
    NSMutableArray *sortedArray = [NSMutableArray arrayWithCapacity:highSection];
    for (int i = 0; i < highSection; i++) {
        NSMutableArray *sectionArray = [NSMutableArray arrayWithCapacity:1];
        [sortedArray addObject:sectionArray];
    }
    
    for (dianhuabenModel *model in array) {
        HanyuPinyinOutputFormat *outputFormat=[[HanyuPinyinOutputFormat alloc] init];
        [outputFormat setToneType:ToneTypeWithoutTone];
        [outputFormat setVCharType:VCharTypeWithV];
        [outputFormat setCaseType:CaseTypeUppercase];
        
        NSString *outputPinyin=[PinyinHelper toHanyuPinyinStringWithNSString:model.name withHanyuPinyinOutputFormat:outputFormat withNSString:@""];
        model.pinyin = [outputPinyin uppercaseString];

        NSString *firstLetter = model.pinyin;
        NSInteger section;
        if (firstLetter.length > 0) { // 如果首字母存在，返回包含首字母的index
            section = [indexCollation sectionForObject:[firstLetter substringToIndex:1] collationStringSelector:@selector(uppercaseString)];
        } else {                // 如果不存在 则放在数组最后
            section = [sortedArray count] - 1;
        }
        [sortedArray[section] addObject:model];
    }
    
    NSMutableArray *sectionMuArr = [NSMutableArray array];
    for (NSMutableArray *muArr in sortedArray) {
        if (muArr.count > 0) {
            dianhuabenSectionModel *sectionModel = [[dianhuabenSectionModel alloc] init];
            sectionModel.contentArray = [self paixuWithArray:muArr];
            dianhuabenModel *model = sectionModel.contentArray.firstObject;
            sectionModel.title = (model.pinyin.length > 0) ? [model.pinyin substringWithRange:NSMakeRange(0, 1)]:@"★";
            [sectionMuArr addObject:sectionModel];
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.block) {
            self.block(sectionMuArr);
        }
    });
}

- (NSArray *)paixuWithArray:(NSArray *)array {
    NSComparator cmptr = ^NSComparisonResult(dianhuabenModel *modele1, dianhuabenModel *modele2) {
        NSString *name1 = modele1.pinyin;
        NSString *name2 = modele2.pinyin;
        return [name1 compare:name2];
    };
    
    array = [[array mutableCopy] sortedArrayUsingComparator:cmptr];
    
    return array;
}

@end
