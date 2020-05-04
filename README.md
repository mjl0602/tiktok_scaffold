# tiktok_scaffold

一个仿抖音主页的手势交互Scaffold，封装了抖音首页的左滑右滑手势，提供简单的组合方式实现抖音主要页面的交互效果。

# Example

详见`./example`下的例子
```dart
TikTokScaffoldController controller = TikTokScaffoldController();

// 监听切换事件，可监听这个controller
PageController _pageController = PageController();

TikTokPageTag _currentTabPage = TikTokPageTag.home;
@override
Widget build(BuildContext context) {
  // 视频列表
  Widget videoList = PageView.builder(
    key: Key('home'),
    controller: _pageController,
    pageSnapping: true,
    physics: ClampingScrollPhysics(),
    scrollDirection: Axis.vertical,
    itemCount: 12,
    itemBuilder: (context, index) => TikTokVideoGesture(
      child: Container(
        color: Color(0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('页面 $index'),
              Text('双击可以点赞'),
              Text(index == 0 ? '下拉可以刷新' : ''),
            ],
          ),
        ),
      ),
    ),
  );
  switch (_currentTabPage) {
    case TikTokPageTag.home:
      break;
    case TikTokPageTag.follow:
    case TikTokPageTag.msg:
    case TikTokPageTag.me:
      videoList = TodoPage(
        title: '其他Tab页面',
      );
  }

  // TikTokScaffold仅包含了左右滑动的UI效果
  // 封装了组合各个页面的逻辑，简单构建类似抖音的页面
  return TikTokScaffold(
    leftPage: TodoPage(
      title: '搜索页',
      onBack: (ctx) {
        controller.animateToMiddle();
      },
    ),
    rightPage: TodoPage(
      title: '个人信息',
      onBack: (ctx) {
        controller.animateToMiddle();
      },
    ),
    enableGesture: true,
    page: videoList,
    controller: controller,
    header: TikTokHeader(
      onSearch: () => controller.animateToLeft(),
    ),
    // 屏幕底部的tabbar切换，tabbar实际上与主要的视频滑动页面是分开的
    // 这是为了方便兼容长屏幕与短屏幕的比例不同，
    // hasBottomPadding与hasBackground一起决定：
    // tabbar是应该叠加在视频之上，还是在视频下方占用单独的高度
    hasBottomPadding: true,
    tabBar: TikTokTabBar(
      hasBackground: true,
      current: _currentTabPage,
      onTabSwitch: (tag) => setState(() => _currentTabPage = tag),
    ),
  );
}

```

## 点赞效果

若要使用双击点赞效果，可以使用example中的TikTokVideoGesture类