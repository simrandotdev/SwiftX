extension UINavigationItem {
    func addImage(image: UIImage, navigationBar: UINavigationBar) {
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        
        let bannerWidth = navigationBar.frame.size.width
        let bannerHeight = navigationBar.frame.size.height
        
        let bannerX = bannerWidth / 2 - image.size.width / 2
        let bannerY = bannerHeight / 2 - image.size.height / 2
        
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        
        self.titleView = imageView
    }
}
