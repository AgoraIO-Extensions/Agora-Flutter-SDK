#include <bnb/glsl.frag>

BNB_IN(0) vec2 var_uv;

BNB_DECLARE_SAMPLER_2D(0, 1, s_src);


BNB_DECLARE_SAMPLER_2D(2, 3, lookupTexture);

vec4 finalColorFilter(vec4 orgColor)
{
    orgColor = min(orgColor,1.);
    const float EPS = 0.000001;
    const float pxSize = 512.0;
    
    float bValue = (orgColor.b * 255.0) / 4.0;
    
    vec2 mulB = clamp(floor(bValue) + vec2(0.0, 1.0), 0.0, 63.0);
    vec2 row = floor(mulB / 8.0 + EPS);
    vec4 row_col = vec4(row, mulB - row * 8.0);
    vec4 lookup = orgColor.ggrr * (63.0/pxSize) + row_col * (64.0/pxSize) + (0.5/pxSize);
    
    float b1w = bValue - mulB.x;
    
    vec3 sampled1 = BNB_TEXTURE_2D(BNB_SAMPLER_2D(lookupTexture), lookup.zx).rgb;
    vec3 sampled2 = BNB_TEXTURE_2D(BNB_SAMPLER_2D(lookupTexture), lookup.wy).rgb;
    
    vec3 res = mix(sampled1, sampled2, b1w);
    return vec4(res, orgColor.a);
}


void main()
{
    bnb_FragColor = finalColorFilter(BNB_TEXTURE_2D(BNB_SAMPLER_2D(s_src), var_uv));
}