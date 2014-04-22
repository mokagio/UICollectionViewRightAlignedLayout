UICollectionView Right Aligned Layout
====================================

A `UICollectionViewLayout` implementation that aligns the cells to the right. 

<img src="https://raw.githubusercontent.com/mokagio/UICollectionViewRightAlignedLayout/master/screenshot.png" />

_Check out the twin project [`UICollectionViewLeftAlignedLayout`](https://github.com/mokagio/UICollectionViewLeftAlignedLayout)_

## Installation with CocoaPods

```ruby
platform :ios, '6.0'

pod 'UICollectionViewRightAlignedLayout'
```

## Usage

Simply set `UICollectionViewRightAlignedLayout` as the layout object for your collection view either via code:

```objc
CGRect frame = ...
UICollectionViewRightAlignedLayout *layout = [UICollectionViewRightAlignedLayout alloc] init];
UICollectionView *RightAlignedCollectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
```

or from Interface Builder:

_img needed here_

`UICollectionViewRightAlignedLayout` is a subclass of `UICollectionViewFlowLayout`, so your collection view delegate can use all the delegate methods of [`UICollectionViewDelegateFlowLayout`](https://developer.apple.com/library/ios/documentation/uikit/reference/UICollectionViewDelegateFlowLayout_protocol/Reference/Reference.html).

For those of you who like consistency there is an `UICollectionViewDelegateRightAlignedLayout` protocol that your delegate object can conform to. Is nothing more than an empty extension of `UICollectionViewDelegateFlowLayout`.

## License

`UICollectionViewRightAlignedLayout` is released under the [MIT license](https://github.com/mokagio/UICollectionViewRightAlignedLayout/blob/master/LICENSE).

---

Hacked together with passion by [@mokagio](https://twitter.com/mokagio)
