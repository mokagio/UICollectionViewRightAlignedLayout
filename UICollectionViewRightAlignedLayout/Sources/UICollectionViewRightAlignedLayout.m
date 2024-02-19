// Copyright (c) 2014 Giovanni Lodi
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "UICollectionViewRightAlignedLayout.h"

@interface UICollectionViewLayoutAttributes (RightAligned)

- (void)rightAlignFrameOnWidth:(CGFloat)width;

@end

@implementation UICollectionViewLayoutAttributes (RightAligned)

- (void)rightAlignFrameOnWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.origin.x = width - frame.size.width;
    self.frame = frame;
}

@end

#pragma mark -

@implementation UICollectionViewRightAlignedLayout

#pragma mark - UICollectionViewLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *originalAttributes = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray *updatedAttributes = [NSMutableArray arrayWithArray:originalAttributes];
    for (UICollectionViewLayoutAttributes *attributes in originalAttributes) {
        if (!attributes.representedElementKind) {
            NSUInteger index = [updatedAttributes indexOfObject:attributes];
            updatedAttributes[index] = [self layoutAttributesForItemAtIndexPath:attributes.indexPath];
        }
    }

    return updatedAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes* currentItemAttributes = [[super layoutAttributesForItemAtIndexPath:indexPath] copy];

    BOOL isFirstItemInSection = indexPath.item == 0;

    if (isFirstItemInSection) {
        [currentItemAttributes rightAlignFrameOnWidth:self.collectionView.frame.size.width];
        return currentItemAttributes;
    }

    NSIndexPath* previousIndexPath = [NSIndexPath indexPathForItem:indexPath.item-1 inSection:indexPath.section];
    CGRect previousFrame = [self layoutAttributesForItemAtIndexPath:previousIndexPath].frame;
    CGRect currentFrame = currentItemAttributes.frame;
    CGRect strecthedCurrentFrame = CGRectMake(0,
                                              currentFrame.origin.y,
                                              self.collectionView.frame.size.width,
                                              currentFrame.size.height);
    // if the current frame, once left aligned to the left and stretched to the full collection view
    // widht intersects the previous frame then they are on the same line
    BOOL isFirstItemInRow = !CGRectIntersectsRect(previousFrame, strecthedCurrentFrame);

    if (isFirstItemInRow) {
        [currentItemAttributes rightAlignFrameOnWidth:self.collectionView.frame.size.width];
        return currentItemAttributes;
    }

    CGFloat previousFrameLeftPoint = previousFrame.origin.x;
    CGRect frame = currentItemAttributes.frame;
    CGFloat minimumInteritemSpacing = [self evaluatedMinimumInteritemSpacingForItemAtIndex:indexPath.row];
    frame.origin.x = previousFrameLeftPoint - minimumInteritemSpacing - frame.size.width;
    currentItemAttributes.frame = frame;
    return currentItemAttributes;
}

- (CGFloat)evaluatedMinimumInteritemSpacingForItemAtIndex:(NSInteger)index
{
    if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
        id<UICollectionViewDelegateRightAlignedLayout> delegate = (id<UICollectionViewDelegateRightAlignedLayout>)self.collectionView.delegate;

        return [delegate collectionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:index];
    } else {
        return self.minimumInteritemSpacing;
    }
}

@end
