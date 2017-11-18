//
//  QKTourCalendarDatasource.m
//  QinKun
//
//  Created by 崔关 on 2017/11/14.
//  Copyright © 2017年 聚格科技. All rights reserved.
//

#import "QKTourCalendarDatasource.h"
#import "QKTourCalendarCollectionViewCell.h"

@implementation QKTourCalendarDatasource

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QKTourCalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    [cell setModel:self.dataArr[indexPath.item]];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (kWIDTH - 6) / 7;
    if (indexPath.item % 7 == 0) {
        return CGSizeMake(floorf(width), width);
    } else {
        return CGSizeMake(width, width);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(tourCalendarSelectWithIndexPath:model:)]) {
        [self.delegate tourCalendarSelectWithIndexPath:indexPath model:self.dataArr[indexPath.item]];
    }
}

@end
