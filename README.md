# swift extensions for iOS
This repo is a collection of swift extensions, often used in iOS development. Even better you can call the function with a namespace format like ```"tom@gmail".ex.isEmailFormat```, this is more swiftly than ```"tom@gmail".ex_isEmailFormat```.

# Extension List 
## String Extensions
| Function | Description |
| :--- | :--- |
|urlEncoded()|url encoded value of string|
|trim|trim the white space and new lines|
|isMobile|whether a string is a mobile phone number|
|isEmailFormat|whether a string is email format|
|attributedString(withLineSpacing:)|get the attributed string with specific linespacing|
|singleLineWidth(withFont:)| get single line string width with specific font|
|singleLineTextSize(withFont:)| get single line string size with specific font|
|textSize(withWidth:font:)|get text size with limited width and specific font|
|textSize(withWidth:textAttributes:)|get text size with limited width and text attributes|
|textSize(withLimitedSize:attributes:)|get text size with limited size and text attributes|
## UIImage Extensions
| Function | Description |
| :--- | :--- |
|cropImage(inArea:)|crop image in area|
|fixImageOrientation()|fix image orientation to up|
|image(withColor:size:)|generate image with specific color and size|
|tintedImage(withColor:)|tint image with specific color|
|tintedImage(withColor:size:)|tint image with specific color and size|
|qrCode(withSting:size:tintColor:backgroundColor:)|generate qr code from string|
|averageColor()|average color from and image|
## UIColor Extensions
| Function | Description |
| :--- | :--- |
|color(hex:alpha:)|init color with hex string, like "0x111111", "#111111"|
|random|random color|
|interpolate(to:fraction:)|get the interpolated color from self to some color|
|components|parse color components|
## UIButton Extensions
| Function | Description |
| :--- | :--- |
|setImageTintColor(_:for:)|change button image tint color for state|
|moveImageToTheRightSide()|flip the image horizontally|
## URL Extensions
| Function | Description |
| :--- | :--- |
|queryParams()|parse query parameters in url string|
## UIDevice Extensions
| Function | Description |
| :--- | :--- |
## UITableView Extensions
| Function | Description |
| :--- | :--- |
|register(_:)|register cell with cell class name|
|dequeueReuseableCell(for:)|dequeue cell at indexpath, example: let cell =  tableView.ex.dequeueReuseableCell(for: indexPath) as SomeCell|
|register(_:)|register header or footer view|
|dequeueReuseableHeaderFooterView()|dequeue header footer view at indexpath, example: let view = tableView.ex.dequeueReuseableHeaderFooterView() as SomeView|
## UICollectionView Extensions
| Function | Description |
| :--- | :--- |
|register(_:)|register cell with cell class name|
|dequeueReusableCell(for:)|dequeue cell at indexpath, example: let cell = collectionView.dequeueReusableCell(for: indexPath) as SomeCell|
|register(_:forSupplementaryViewOfKind:)|register supplementary view with enum UICollectionElementKindSection|
|dequeueReusableSupplementaryView(ofKind:for:)|dequeue supplementay view, example: let header = collectionView.ex.dequeueReusableSupplementaryView(ofKind: .Header, for: IndexPath) as SomeView|
## UIScrollView Extensions
| Function | Description |
| :--- | :--- |
|scroll(to:animated:)|scroll to position|
|setContentOffsetWithoutTriggerScroll(_:)|set bounds, this will not trgger scroll view scroll|
## Timer Extensions
| Function | Description |
| :--- | :--- |
## Date Extensions
| Function | Description |
| :--- | :--- |

# Install
## Carthage
add `github "holysin/Extensions" ~> 1.0` to your Cartfile, and run ```Carthage update```

# Contributions
There are so many useful extensions in our development progress, if you want to contribute, fork and make pull request. Thank you!

## Docs
there is a ```gen_doc.rb``` file in the repo root, this is for generate the Extensions List docs with markdown format. if you contribute extension, please add standard comment for the functions, and run the ```gen_doc.rb``` script, and this will generate a file named ```document.md```. paste the content in the ```document.md``` into ```README.md```


