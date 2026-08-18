// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get settings => '设置';

  @override
  String get sectionSlideshow => '幻灯片';

  @override
  String get slideDuration => '显示时长';

  @override
  String get transitionDuration => '过渡时长';

  @override
  String get blurBorders => '模糊边框';

  @override
  String get blurBordersSubtitle => '将图片延展至全屏';

  @override
  String get unitMinutes => '分钟';

  @override
  String get unitSeconds => '秒';

  @override
  String get unitMilliseconds => '毫秒';

  @override
  String get transitionEffect => '切换效果';

  @override
  String get transitionEffectRandom => '随机';

  @override
  String get transitionEffectFade => '淡入淡出';

  @override
  String get transitionEffectSlideRight => '从右滑入';

  @override
  String get transitionEffectSlideLeft => '从左滑入';

  @override
  String get transitionEffectSlideUp => '向上滑入';

  @override
  String get transitionEffectSlideDown => '向下滑入';

  @override
  String get transitionEffectZoomIn => '放大进入';

  @override
  String get transitionEffectZoomOut => '缩小进入';

  @override
  String get transitionEffectRotate => '旋转';

  @override
  String get transitionEffectFlip => '3D 翻转';

  @override
  String get transitionEffectBlur => '模糊消散';

  @override
  String get sectionClock => '时钟';

  @override
  String get showClock => '显示时钟';

  @override
  String get showClockSubtitle => '在幻灯片上显示时间';

  @override
  String get size => '大小';

  @override
  String get position => '位置';

  @override
  String get sectionPhotoInfo => '照片信息';

  @override
  String get showPhotoInfo => '显示照片信息';

  @override
  String get showPhotoInfoSubtitle => '在幻灯片上显示日期和地点';

  @override
  String get useScriptFont => '使用手写字体';

  @override
  String get useScriptFontSubtitle => '以优雅的手写体显示元数据';

  @override
  String get resolveLocationNames => '解析地点名称';

  @override
  String get resolveLocationNamesSubtitle => '使用 OpenStreetMap 显示地名，而非经纬度坐标';

  @override
  String get nominatimHint => '使用 Nominatim（OpenStreetMap），无需 API 密钥。';

  @override
  String get sectionPhotoSource => '照片来源';

  @override
  String get appFolder => '应用文件夹';

  @override
  String get appFolderSubtitle => '存放在应用文件夹中的照片';

  @override
  String get appFolderWarning => '请将照片复制到此文件夹。卸载应用时这些照片会被一并删除。';

  @override
  String get devicePhotos => '设备相册';

  @override
  String get devicePhotosSubtitle => '显示设备中的照片';

  @override
  String get localFolder => '本地文件夹';

  @override
  String get localFolderSubtitle => '使用本地文件夹中的照片';

  @override
  String get localFolderSubtitleAndroid => '播放设备上任意文件夹中的照片';

  @override
  String get allFilesAccessExplanation =>
      '读取应用之外的文件夹需要「所有文件访问」权限，Android 会在系统设置中向你申请。';

  @override
  String get grantAllFilesAccess => '授予文件夹访问权限';

  @override
  String get nextcloud => 'Nextcloud';

  @override
  String get nextcloudSubtitle => '从 Nextcloud 公共分享链接同步';

  @override
  String get loading => '加载中…';

  @override
  String get loadingAlbums => '正在加载相册…';

  @override
  String get tapToLoadAlbums => '点击加载设备相册';

  @override
  String get load => '加载';

  @override
  String get photoAlbum => '相册';

  @override
  String get allPhotos => '全部照片';

  @override
  String get refreshAlbums => '刷新相册';

  @override
  String get change => '更改';

  @override
  String get reset => '重置';

  @override
  String get photoPermissionDenied => '照片权限被拒绝';

  @override
  String errorLoadingAlbums(String error) {
    return '加载相册出错：$error';
  }

  @override
  String failedToPickFolder(String error) {
    return '选择文件夹失败：$error';
  }

  @override
  String get selectPhotoFolder => '选择照片文件夹';

  @override
  String get nextcloudPublicShareUrl => 'Nextcloud 公共分享链接';

  @override
  String get nextcloudUrlHint => 'https://cloud.example.com/s/abc123';

  @override
  String get webdavAuthPublicShare => '公共分享';

  @override
  String get webdavAuthLogin => 'WebDAV 登录';

  @override
  String get webdavUrlLabel => 'WebDAV 地址';

  @override
  String get webdavUrlHint =>
      'https://cloud.example.com/remote.php/dav/files/user/';

  @override
  String get webdavUsername => '用户名';

  @override
  String get webdavPassword => '密码';

  @override
  String get webdavAllowInvalidCertificate => '接受无效证书';

  @override
  String get webdavAllowInvalidCertificateWarning => '不安全：仅适用于可信网络中的自签名证书。';

  @override
  String get testConnection => '测试连接';

  @override
  String get testing => '测试中…';

  @override
  String get connectionSuccessful => '连接成功！';

  @override
  String get syncAllNextcloudFolders => '全部文件夹';

  @override
  String get syncAllNextcloudFoldersSubtitle => '同步分享根目录及其所有子文件夹中的图片';

  @override
  String get syncSelectedNextcloudFolders => '指定文件夹';

  @override
  String get syncSelectedNextcloudFoldersSubtitle => '选择需要使用其直属图片的文件夹';

  @override
  String get loadNextcloudFolders => '加载文件夹';

  @override
  String get loadingNextcloudFolders => '正在加载文件夹…';

  @override
  String get nextcloudFolderSelectionHint => '请勾选分享根目录以及需要包含的子文件夹。';

  @override
  String get nextcloudShareRoot => '分享根目录';

  @override
  String get nextcloudShareRootSubtitle => '直接位于分享根目录中的图片';

  @override
  String nextcloudFolderPhotoCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 张照片',
    );
    return '$_temp0';
  }

  @override
  String nextcloudFoldersLoadError(String error) {
    return '加载文件夹出错：$error';
  }

  @override
  String get autoSyncInterval => '自动同步间隔';

  @override
  String get disabled => '已关闭';

  @override
  String get deleteOrphanedFiles => '删除多余文件';

  @override
  String get deleteOrphanedFilesSubtitle => '删除服务器上已不存在的本地文件';

  @override
  String get syncNow => '立即同步';

  @override
  String get syncing => '同步中…';

  @override
  String get syncCompletedSuccessfully => '同步完成！';

  @override
  String get syncCancelled => '同步已取消。';

  @override
  String syncError(String error) {
    return '错误：$error';
  }

  @override
  String get nextcloudErrorInvalidShareLink => '该 Nextcloud 分享链接已失效。';

  @override
  String get nextcloudErrorShareInaccessible => '该 Nextcloud 分享已无法访问。';

  @override
  String get nextcloudErrorConnectionTimeout => '连接 Nextcloud 超时。';

  @override
  String get nextcloudErrorConnectionFailed => '无法连接到 Nextcloud，请检查网络连接和分享链接。';

  @override
  String get nextcloudErrorDownloadStalled => '下载超时：15 分钟内未收到任何数据。';

  @override
  String get nextcloudErrorInvalidUrlEmpty => '地址为空。';

  @override
  String get nextcloudErrorInvalidUrlScheme => '地址协议无效，请使用 http 或 https。';

  @override
  String get nextcloudErrorInvalidUrlNoHost => '地址无效，缺少主机名。';

  @override
  String nextcloudErrorInvalidUrlFormat(String error) {
    return '地址格式无效：$error';
  }

  @override
  String nextcloudErrorUnknown(String error) {
    return 'Nextcloud 同步失败：$error';
  }

  @override
  String get neverSynced => '从未同步';

  @override
  String get lastSyncJustNow => '上次同步：刚刚';

  @override
  String lastSyncMinutesAgo(int minutes) {
    return '上次同步：$minutes 分钟前';
  }

  @override
  String lastSyncHoursAgo(int hours) {
    return '上次同步：$hours 小时前';
  }

  @override
  String lastSyncDate(String date) {
    return '上次同步：$date';
  }

  @override
  String get sectionDisplaySchedule => '定时开关屏';

  @override
  String get dayNightSchedule => '日夜时间表';

  @override
  String get dayNightScheduleSubtitle => '夜间自动关闭屏幕';

  @override
  String get dayStartsAt => '白天开始于';

  @override
  String get nightStartsAt => '夜间开始于';

  @override
  String get differentNightTimeOnFridaysAndSaturdays => '周五和周六使用不同的夜间时间';

  @override
  String get differentNightTimeFridaysAndSaturdays => '周五和周六夜间开始于';

  @override
  String get nativeScreenOff => '系统级熄屏';

  @override
  String get nativeScreenOffEnabledSubtitle => '使用设备管理器完全关闭屏幕';

  @override
  String get nativeScreenOffDisabledSubtitle => '需要设备管理器权限';

  @override
  String get deviceAdminExplanation => '完全关闭屏幕需要设备管理器权限。未授予时，屏幕只会调暗。';

  @override
  String get grantDeviceAdmin => '授予设备管理器权限';

  @override
  String get deviceAdminEnabled => '设备管理器已启用——屏幕将完全关闭';

  @override
  String get screenLockWarning =>
      '重要：必须关闭屏幕锁（PIN／图案／密码），自动唤醒才能生效。请前往 设置 → 安全 → 屏幕锁定 → 无。';

  @override
  String get deviceAdminActive => '设备管理器已激活';

  @override
  String get deviceAdminUninstallWarning => '要卸载本应用，需先在 Android 设置中停用设备管理器权限。';

  @override
  String get openDeviceAdminSettings => '打开设备管理器设置';

  @override
  String get sectionAndroid => 'Android';

  @override
  String get startOnBoot => '开机自启';

  @override
  String get startOnBootSubtitle => '设备启动时自动打开应用';

  @override
  String get keepAppRunning => '保持应用运行';

  @override
  String get keepAppRunningSubtitle => '防止应用在内存不足时被系统结束';

  @override
  String get notificationPermissionRequired => '「保持应用运行」需要通知权限';

  @override
  String get autoUpdateTitle => '自动更新';

  @override
  String get autoUpdateSubtitle => '检查 GitHub 上的新版本并安装';

  @override
  String get autoUpdateFdroidNote =>
      '仅适用于从 GitHub 安装的版本。若通过 F-Droid 安装，请关闭此项并从 F-Droid 更新。';

  @override
  String get autoUpdateSilentTitle => '免确认安装';

  @override
  String get autoUpdateSilentSubtitle => '已检测到设备所有者权限：更新可在后台静默安装。';

  @override
  String get autoUpdatePromptNote => '有可用更新时，会先征求你的同意再安装。';

  @override
  String get autoUpdateCheckNow => '立即检查';

  @override
  String get autoUpdateUpToDate => '已是最新版本。';

  @override
  String get updateAvailableTitle => '有可用更新';

  @override
  String updateAvailableMessage(String version) {
    return '发现新版本 $version，现在下载并安装吗？';
  }

  @override
  String get updateDownloading => '下载中…';

  @override
  String get updateSkip => '跳过';

  @override
  String get updateDownloadInstall => '下载并安装';

  @override
  String get keepAliveDialogTitle => '保持应用运行';

  @override
  String get keepAliveWhatDoes => '这个功能有什么用？';

  @override
  String get keepAliveWhatDoesExplanation => '该功能让相框应用持续运行，即使设备内存不足也不会被中断。';

  @override
  String get keepAliveWhyNeed => '我为什么需要它？';

  @override
  String get keepAliveWhyNeedExplanation =>
      '在内存较小的老旧设备上，Android 可能会结束应用以释放内存。开启后应用将以前台服务方式运行，从而避免被结束。';

  @override
  String get keepAliveWhatHappens => '开启后会发生什么？';

  @override
  String get keepAliveWhatHappensExplanation =>
      '• 状态栏会出现一条常驻通知\n• 应用被 Android 结束的可能性大幅降低\n• 在 Android 13 及以上版本，需要授予通知权限';

  @override
  String get keepAliveDisableAnytime => '你随时可以在设置中关闭此功能。';

  @override
  String get cancel => '取消';

  @override
  String get enable => '开启';

  @override
  String get about => '关于';

  @override
  String aboutSubtitle(String version) {
    return 'Open Photo Frame v$version';
  }

  @override
  String get configRecoveredFromBackup => '配置文件已损坏，已读取备份。应用以最近一次保存的版本启动。';

  @override
  String get configResetToDefaults => '配置文件已损坏，且未找到可用备份。应用以未配置状态启动。';

  @override
  String get noPhotosFound => '未找到照片';

  @override
  String get tapCenterToOpenSettings => '点击屏幕中央打开设置';

  @override
  String get screenOrientation => '屏幕方向';

  @override
  String get screenOrientationAuto => '自动（重力感应）';

  @override
  String get screenOrientationPortraitUp => '竖屏';

  @override
  String get screenOrientationPortraitDown => '竖屏（倒置）';

  @override
  String get screenOrientationLandscapeLeft => '横屏（左）';

  @override
  String get screenOrientationLandscapeRight => '横屏（右）';
}
