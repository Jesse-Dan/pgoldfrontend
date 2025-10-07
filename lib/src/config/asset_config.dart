class AssetConfig {
  static const String _iconsPath = 'assets/icons/';
  static const String _imagesPath = 'assets/images/';
  static const String _logosPath = 'assets/logos/';
  static const String _svgExt = '.svg';
  static const String _pngExt = '.png';

  // --- DYNAMIC BUILDER METHOD ---
  /// Builds the full asset path dynamically.
  /// @param folderPath: The base folder path (e.g., _iconsPath).
  /// @param fileName: The name of the file *without* extension.
  /// @param extension: The file extension (e.g., _svgExt).
  static String _buildPath({
    required String folderPath,
    required String fileName,
    required String extension,
  }) {
    return '$folderPath$fileName$extension';
  }

  static final String arrowLeftDownCircle = _buildPath(
    folderPath: _iconsPath,
    fileName: 'arrow-left-down-circle',
    extension: _svgExt,
  );
  static final String bars = _buildPath(
    folderPath: _iconsPath,
    fileName: 'bars',
    extension: _svgExt,
  );
  static final String home3 = _buildPath(
    folderPath: _iconsPath,
    fileName: 'home-3',
    extension: _svgExt,
  );
  static final String planeUp = _buildPath(
    folderPath: _iconsPath,
    fileName: 'plane-up',
    extension: _svgExt,
  );
  static final String plus = _buildPath(
    folderPath: _iconsPath,
    fileName: 'plus',
    extension: _svgExt,
  );

  static final String send = _buildPath(
    folderPath: _iconsPath,
    fileName: 'Send',
    extension: _svgExt,
  );

  static final String vector = _buildPath(
    folderPath: _iconsPath,
    fileName: 'Vector',
    extension: _svgExt,
  );

  // Information & Status Icons
  static final String bell = _buildPath(
    folderPath: _iconsPath,
    fileName: 'bell',
    extension: _svgExt,
  );
  static final String infoCircle = _buildPath(
    folderPath: _iconsPath,
    fileName: 'info-circle',
    extension: _svgExt,
  );
  static final String questionCircle = _buildPath(
    folderPath: _iconsPath,
    fileName: 'question-circle',
    extension: _svgExt,
  );
  static final String star = _buildPath(
    folderPath: _iconsPath,
    fileName: 'star',
    extension: _svgExt,
  );
  static final String lightbulb = _buildPath(
    folderPath: _iconsPath,
    fileName: 'lightbulb',
    extension: _svgExt,
  );

  // User & Profile Icons
  static final String multiUser = _buildPath(
    folderPath: _iconsPath,
    fileName: 'multi-user',
    extension: _svgExt,
  );
  static final String userCircle = _buildPath(
    folderPath: _iconsPath,
    fileName: 'user-circle',
    extension: _svgExt,
  );
  static final String userIcon = _buildPath(
    folderPath: _iconsPath,
    fileName: 'user_icon',
    extension: _svgExt,
  );

  // Finance & E-commerce Icons
  static final String bitcoin = _buildPath(
    folderPath: _iconsPath,
    fileName: 'bitcoin',
    extension: _svgExt,
  );
  static final String cardPos = _buildPath(
    folderPath: _iconsPath,
    fileName: 'card-pos',
    extension: _svgExt,
  );
  static final String giftCard = _buildPath(
    folderPath: _iconsPath,
    fileName: 'gift-card',
    extension: _svgExt,
  );

  // Utility & Interface Icons
  static final String calculator2 = _buildPath(
    folderPath: _iconsPath,
    fileName: 'calculator-2',
    extension: _svgExt,
  );
  static final String commentDots = _buildPath(
    folderPath: _iconsPath,
    fileName: 'comment-dots',
    extension: _svgExt,
  );

  static final String component4 = _buildPath(
    folderPath: _iconsPath,
    fileName: 'Component 4',
    extension: _svgExt,
  );
  static final String database = _buildPath(
    folderPath: _iconsPath,
    fileName: 'database',
    extension: _svgExt,
  );
  static final String dribbble = _buildPath(
    folderPath: _iconsPath,
    fileName: 'dribbble',
    extension: _svgExt,
  );
  static final String eye = _buildPath(
    folderPath: _iconsPath,
    fileName: 'eye',
    extension: _svgExt,
  );
  static final String globe = _buildPath(
    folderPath: _iconsPath,
    fileName: 'globe',
    extension: _svgExt,
  );

  static final String mailIcon = _buildPath(
    folderPath: _iconsPath,
    fileName: 'mail_icon',
    extension: _svgExt,
  );
  static final String tv = _buildPath(
    folderPath: _iconsPath,
    fileName: 'tv',
    extension: _svgExt,
  );

  // Logo Images

  static final String appIcon = _buildPath(
    folderPath: _logosPath,
    fileName: 'app_icon',
    extension: _pngExt,
  );

  static final String launchIcon = _buildPath(
    folderPath: _logosPath,
    fileName: 'Group',
    extension: _svgExt,
  );

  static final String ob_1 = _buildPath(
    folderPath: _imagesPath,
    fileName: 'ob_1',
    extension: _pngExt,
  );

  static final String ob_2 = _buildPath(
    folderPath: _imagesPath,
    fileName: 'ob_2',
    extension: _pngExt,
  );

  static final String earn_cash_image = _buildPath(
    folderPath: _imagesPath,
    fileName: 'Frame 2087327400',
    extension: _pngExt,
  );

  static final String status_image = _buildPath(
    folderPath: _imagesPath,
    fileName: 'status_image',
    extension: _svgExt,
  );

  static final String pgoldPatterns = _buildPath(
    folderPath: _imagesPath,
    fileName: 'PgoldPatterns',
    extension: _pngExt,
  );
}
