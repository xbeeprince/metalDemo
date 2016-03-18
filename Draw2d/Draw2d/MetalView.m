//
//  MetalView.m
//  Draw2d
//
//  Created by Volvet Zhang on 16/3/18.
//  Copyright © 2016年 volvet. All rights reserved.
//

#import "MetalView.h"

@import simd;

typedef struct {
    vector_float4  position;
    vector_float4  color;
} MetalVertex;

@interface MetalView()

@property (nonatomic, strong)  CADisplayLink * mDisplayLink;
@property (nonatomic, strong)  id<MTLDevice>   mDevice;
@property (nonatomic, strong)  id<MTLRenderPipelineState>  mPipeline;
@property (nonatomic, strong)  id<MTLCommandQueue>   mCommandQueue;
@property (nonatomic, strong)  id<MTLBuffer>     mVertexBuffer;

@end

@implementation MetalView

+ (Class) layerClass {
    return [CAMetalLayer class];
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    if( self = [super initWithCoder:aDecoder] ){
        [self mtlDeviceInit];
    }
    
    return self;
}

- (void) dealloc {
    [self.mDisplayLink invalidate];
}

- (CAMetalLayer*) metalLayer {
    return (CAMetalLayer*)self.layer;
}

- (void) mtlDeviceInit {
    self.mDevice = MTLCreateSystemDefaultDevice();
    self.metalLayer.device = self.mDevice;
    self.metalLayer.pixelFormat = MTLPixelFormatBGRA8Unorm;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    
    if( self.subviews ){
        self.mDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkDidFire:)];
        [self.mDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    } else {
        [self.mDisplayLink invalidate];
        self.mDisplayLink = nil;
    }
}

- (void)displayLinkDidFire:(CADisplayLink*)displayLink {
    [self redraw];
}

- (void) redraw {
    
}



@end