// Shader created with Shader Forge Beta 0.25 
// Shader Forge (c) Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:0.25;sub:START;pass:START;ps:flbk:,lico:1,lgpr:1,nrmq:1,limd:2,uamb:True,mssp:True,lmpd:False,lprd:False,enco:True,frtr:True,vitr:True,dbil:True,rmgx:False,hqsc:True,hqlp:False,blpr:0,bsrc:0,bdst:0,culm:0,dpts:2,wrdp:True,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5530925,fgcg:0.6351374,fgcb:0.6838235,fgca:1,fgde:0.01,fgrn:0,fgrf:300,ofsf:0,ofsu:0;n:type:ShaderForge.SFN_Final,id:1,x:32101,y:32621|diff-92-OUT,spec-374-OUT,gloss-57-OUT,emission-88-OUT;n:type:ShaderForge.SFN_Color,id:2,x:33225,y:32066,ptlb:Diffuse Color,c1:0.7867647,c2:0.2487565,c3:0.2487565,c4:1;n:type:ShaderForge.SFN_Fresnel,id:44,x:33626,y:32822|EXP-446-OUT;n:type:ShaderForge.SFN_Lerp,id:45,x:33460,y:32802|A-46-OUT,B-44-OUT,T-451-OUT;n:type:ShaderForge.SFN_Vector1,id:46,x:33626,y:32773,v1:1;n:type:ShaderForge.SFN_Exp,id:57,x:32617,y:32656,et:0|IN-834-OUT;n:type:ShaderForge.SFN_Multiply,id:63,x:32617,y:32822|A-924-RGB,B-374-OUT;n:type:ShaderForge.SFN_Multiply,id:64,x:33285,y:32777|A-87-G,B-45-OUT;n:type:ShaderForge.SFN_Tex2d,id:87,x:34394,y:32357,ptlb:LM (R)  Scratches (G)  Dirt (B),tex:e71f528961d725f49b9a55b8594486d9,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:88,x:32449,y:32822|A-63-OUT,B-87-R;n:type:ShaderForge.SFN_Multiply,id:92,x:32385,y:32520|A-319-OUT,B-87-R;n:type:ShaderForge.SFN_Tex2d,id:132,x:33224,y:32228,ptlb:Pattern,tex:f63740626bfed114cb343f131bfd6878,ntxv:0,isnm:False|UVIN-138-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:133,x:33743,y:31984,uv:0;n:type:ShaderForge.SFN_Append,id:134,x:33741,y:32124|A-526-OUT,B-489-OUT;n:type:ShaderForge.SFN_Slider,id:135,x:34392,y:31943,ptlb:Tile U,min:0,cur:0,max:4;n:type:ShaderForge.SFN_Slider,id:136,x:34392,y:32128,ptlb:Tile V,min:0,cur:0,max:4;n:type:ShaderForge.SFN_Multiply,id:137,x:33560,y:32120|A-133-UVOUT,B-134-OUT;n:type:ShaderForge.SFN_Rotator,id:138,x:33392,y:32228|UVIN-137-OUT,ANG-140-OUT;n:type:ShaderForge.SFN_Slider,id:140,x:33560,y:32288,ptlb:Pattern Rotation,min:0,cur:0,max:3.141593;n:type:ShaderForge.SFN_Color,id:141,x:33365,y:32062,ptlb:Pattern Color,c1:0.2361592,c2:0.5241261,c3:0.7647059,c4:1;n:type:ShaderForge.SFN_Lerp,id:142,x:33028,y:32213|A-2-RGB,B-141-RGB,T-132-RGB;n:type:ShaderForge.SFN_Lerp,id:223,x:32859,y:32290|A-142-OUT,B-224-OUT,T-87-G;n:type:ShaderForge.SFN_Vector1,id:224,x:33028,y:32357,v1:1;n:type:ShaderForge.SFN_Lerp,id:319,x:32546,y:32387|A-223-OUT,B-407-OUT,T-787-OUT;n:type:ShaderForge.SFN_Slider,id:337,x:34264,y:32578,ptlb:Dirt,min:-0.1,cur:0.2849046,max:1;n:type:ShaderForge.SFN_Multiply,id:374,x:33064,y:32777|A-64-OUT,B-824-OUT;n:type:ShaderForge.SFN_Vector3,id:407,x:32717,y:32405,v1:0.6102941,v2:0.5040808,v3:0.4352833;n:type:ShaderForge.SFN_Vector1,id:446,x:33791,y:32842,v1:1.5;n:type:ShaderForge.SFN_Vector1,id:451,x:33626,y:32941,v1:0.5;n:type:ShaderForge.SFN_Exp,id:469,x:34233,y:32128,et:0|IN-136-OUT;n:type:ShaderForge.SFN_Exp,id:474,x:34233,y:31943,et:0|IN-135-OUT;n:type:ShaderForge.SFN_Vector1,id:488,x:34063,y:32269,v1:2;n:type:ShaderForge.SFN_Divide,id:489,x:33902,y:32141|A-533-OUT,B-488-OUT;n:type:ShaderForge.SFN_Subtract,id:526,x:34063,y:31943|A-474-OUT,B-527-OUT;n:type:ShaderForge.SFN_Vector1,id:527,x:34233,y:32078,v1:1;n:type:ShaderForge.SFN_Subtract,id:533,x:34063,y:32128|A-469-OUT,B-527-OUT;n:type:ShaderForge.SFN_Lerp,id:787,x:33978,y:32473|A-788-OUT,B-87-B,T-337-OUT;n:type:ShaderForge.SFN_Vector1,id:788,x:34146,y:32473,v1:0;n:type:ShaderForge.SFN_OneMinus,id:824,x:33285,y:32656|IN-787-OUT;n:type:ShaderForge.SFN_Multiply,id:834,x:32786,y:32656|A-874-OUT,B-374-OUT;n:type:ShaderForge.SFN_Vector1,id:874,x:32954,y:32656,v1:30;n:type:ShaderForge.SFN_Cubemap,id:924,x:32786,y:32822,ptlb:Cube,cube:07bc4fb87bcf6bf4488eb23d5b275a76,pvfc:0|MIP-955-OUT;n:type:ShaderForge.SFN_OneMinus,id:941,x:32994,y:32995|IN-374-OUT;n:type:ShaderForge.SFN_Multiply,id:945,x:32799,y:33019|A-941-OUT,B-998-OUT;n:type:ShaderForge.SFN_Exp,id:955,x:32631,y:33018,et:0|IN-945-OUT;n:type:ShaderForge.SFN_Vector1,id:998,x:32994,y:33125,v1:2;proporder:2-141-135-136-140-337-132-87-924;pass:END;sub:END;*/

Shader "Custom/Apocaliptic Car" {
    Properties {
        _DiffuseColor ("Diffuse Color", Color) = (0.7867647,0.2487565,0.2487565,1)
        _PatternColor ("Pattern Color", Color) = (0.2361592,0.5241261,0.7647059,1)
        _TileU ("Tile U", Range(0, 4)) = 0
        _TileV ("Tile V", Range(0, 4)) = 0
        _PatternRotation ("Pattern Rotation", Range(0, 3.141593)) = 0
        _Dirt ("Dirt", Range(-0.1, 1)) = 0.2849046
        _Pattern ("Pattern", 2D) = "white" {}
        _LMRScratchesGDirtB ("LM (R)  Scratches (G)  Dirt (B)", 2D) = "white" {}
        _Cube ("Cube", Cube) = "_Skybox" {}
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "ForwardBase"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma exclude_renderers xbox360 ps3 flash 
            #pragma target 3.0
            #pragma glsl
            uniform float4 _LightColor0;
            uniform float4 _DiffuseColor;
            uniform sampler2D _LMRScratchesGDirtB; uniform float4 _LMRScratchesGDirtB_ST;
            uniform sampler2D _Pattern; uniform float4 _Pattern_ST;
            uniform float _TileU;
            uniform float _TileV;
            uniform float _PatternRotation;
            uniform float4 _PatternColor;
            uniform float _Dirt;
            uniform samplerCUBE _Cube;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 uv0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.uv0 = v.uv0;
                o.normalDir = mul(float4(v.normal,0), _World2Object).xyz;
                o.posWorld = mul(_Object2World, v.vertex);
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
/////// Normals:
                float3 normalDirection =  i.normalDir;
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i)*2;
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
                float NdotL = dot( normalDirection, lightDirection );
                float3 diffuse = max( 0.0, NdotL)*InvPi * attenColor + UNITY_LIGHTMODEL_AMBIENT.xyz*2;
////// Emissive:
                float2 node_1016 = i.uv0;
                float4 node_87 = tex2D(_LMRScratchesGDirtB,TRANSFORM_TEX(node_1016.rg, _LMRScratchesGDirtB));
                float node_787 = lerp(0.0,node_87.b,_Dirt);
                float node_374 = ((node_87.g*lerp(1.0,pow(1.0-max(0,dot(normalDirection, viewDirection)),1.5),0.5))*(1.0 - node_787));
                float3 emissive = ((texCUBElod(_Cube,float4(viewReflectDirection,exp(((1.0 - node_374)*2.0)))).rgb*node_374)*node_87.r);
///////// Gloss:
                float gloss = exp((30.0*node_374));
////// Specular:
                NdotL = max(0.0, NdotL);
                float3 specularColor = float3(node_374,node_374,node_374);
                float specularMonochrome = dot(specularColor,float3(0.3,0.59,0.11));
                float normTerm = (gloss + 2.0 ) / (2.0 * Pi);
                float3 specular = (floor(attenuation) * _LightColor0.xyz) * pow(max(0,dot(reflect(-lightDirection, normalDirection),viewDirection)),gloss) * specularColor*normTerm;
                float3 finalColor = 0;
                float3 diffuseLight = diffuse;
                diffuseLight *= 1-specularMonochrome;
                float node_138_ang = _PatternRotation;
                float node_138_spd = 1.0;
                float node_138_cos = cos(node_138_spd*node_138_ang);
                float node_138_sin = sin(node_138_spd*node_138_ang);
                float2 node_138_piv = float2(0.5,0.5);
                float node_527 = 1.0;
                float2 node_138 = (mul((i.uv0.rg*float2((exp(_TileU)-node_527),((exp(_TileV)-node_527)/2.0)))-node_138_piv,float2x2( node_138_cos, -node_138_sin, node_138_sin, node_138_cos))+node_138_piv);
                float node_224 = 1.0;
                finalColor += diffuseLight * (lerp(lerp(lerp(_DiffuseColor.rgb,_PatternColor.rgb,tex2D(_Pattern,TRANSFORM_TEX(node_138, _Pattern)).rgb),float3(node_224,node_224,node_224),node_87.g),float3(0.6102941,0.5040808,0.4352833),node_787)*node_87.r);
                finalColor += specular;
                finalColor += emissive;
/// Final Color:
                return fixed4(finalColor,1);
            }
            ENDCG
        }
        Pass {
            Name "ForwardAdd"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            Fog { Color (0,0,0,0) }
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma exclude_renderers xbox360 ps3 flash 
            #pragma target 3.0
            #pragma glsl
            uniform float4 _LightColor0;
            uniform float4 _DiffuseColor;
            uniform sampler2D _LMRScratchesGDirtB; uniform float4 _LMRScratchesGDirtB_ST;
            uniform sampler2D _Pattern; uniform float4 _Pattern_ST;
            uniform float _TileU;
            uniform float _TileV;
            uniform float _PatternRotation;
            uniform float4 _PatternColor;
            uniform float _Dirt;
            uniform samplerCUBE _Cube;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 uv0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.uv0 = v.uv0;
                o.normalDir = mul(float4(v.normal,0), _World2Object).xyz;
                o.posWorld = mul(_Object2World, v.vertex);
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
/////// Normals:
                float3 normalDirection =  i.normalDir;
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i)*2;
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float Pi = 3.141592654;
                float InvPi = 0.31830988618;
                float NdotL = dot( normalDirection, lightDirection );
                float3 diffuse = max( 0.0, NdotL)*InvPi * attenColor;
///////// Gloss:
                float2 node_1017 = i.uv0;
                float4 node_87 = tex2D(_LMRScratchesGDirtB,TRANSFORM_TEX(node_1017.rg, _LMRScratchesGDirtB));
                float node_787 = lerp(0.0,node_87.b,_Dirt);
                float node_374 = ((node_87.g*lerp(1.0,pow(1.0-max(0,dot(normalDirection, viewDirection)),1.5),0.5))*(1.0 - node_787));
                float gloss = exp((30.0*node_374));
////// Specular:
                NdotL = max(0.0, NdotL);
                float3 specularColor = float3(node_374,node_374,node_374);
                float specularMonochrome = dot(specularColor,float3(0.3,0.59,0.11));
                float normTerm = (gloss + 2.0 ) / (2.0 * Pi);
                float3 specular = attenColor * pow(max(0,dot(reflect(-lightDirection, normalDirection),viewDirection)),gloss) * specularColor*normTerm;
                float3 finalColor = 0;
                float3 diffuseLight = diffuse;
                diffuseLight *= 1-specularMonochrome;
                float node_138_ang = _PatternRotation;
                float node_138_spd = 1.0;
                float node_138_cos = cos(node_138_spd*node_138_ang);
                float node_138_sin = sin(node_138_spd*node_138_ang);
                float2 node_138_piv = float2(0.5,0.5);
                float node_527 = 1.0;
                float2 node_138 = (mul((i.uv0.rg*float2((exp(_TileU)-node_527),((exp(_TileV)-node_527)/2.0)))-node_138_piv,float2x2( node_138_cos, -node_138_sin, node_138_sin, node_138_cos))+node_138_piv);
                float node_224 = 1.0;
                finalColor += diffuseLight * (lerp(lerp(lerp(_DiffuseColor.rgb,_PatternColor.rgb,tex2D(_Pattern,TRANSFORM_TEX(node_138, _Pattern)).rgb),float3(node_224,node_224,node_224),node_87.g),float3(0.6102941,0.5040808,0.4352833),node_787)*node_87.r);
                finalColor += specular;
/// Final Color:
                return fixed4(finalColor * 1,0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
