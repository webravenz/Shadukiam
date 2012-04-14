//
//  Game.m
//  AppScaffold
//

#import "Game.h" 

// --- private interface ---------------------------------------------------------------------------

@interface Game ()

- (void)setup;

@end


// --- class implementation ------------------------------------------------------------------------

@implementation Game

static int stageWidth;
static int stageHeight;

@synthesize gameWidth  = mGameWidth;
@synthesize gameHeight = mGameHeight;

- (id)initWithWidth:(float)width height:(float)height
{
    if ((self = [super init]))
    {
        mGameWidth = width;
        mGameHeight = height;
        
        [self setup];
    }
    return self;
}


- (void)setup
{
    // This is where the code of your game will start. 
    // In this sample, we add just a few simple elements to get a feeling about how it's done.
    
    [SPAudioEngine start];  // starts up the sound engine
    
    
    // The Application contains a very handy "Media" class which loads your texture atlas
    // and all available sound files automatically. Extend this class as you need it --
    // that way, you will be able to access your textures and sounds throughout your 
    // application, without duplicating any resources.
    
    [Media initAtlas];      // loads your texture atlas -> see Media.h/Media.m
    [Media initSound];      // loads all your sounds    -> see Media.h/Media.m
    
    stageWidth = mGameHeight;
    stageHeight = mGameWidth;
    xOrigin = -80;
    yOrigin = 80;
    
    SPImage *background = [SPImage imageWithContentsOfFile:@"fond.jpg"];
    background.x = xOrigin;
    background.y = yOrigin;
    [self addChild:background];
    
    // pagemanager
    [self addChild:[PageManager getInstance]];
    [PageManager getInstance].x = xOrigin;
    [PageManager getInstance].y = yOrigin;
    [[PageManager getInstance] changePage:@"PagePlay"];
    
}

+ (int)stageWidth {
    return stageWidth;
}

+ (int)stageHeight {
    return stageHeight;
}

@end
