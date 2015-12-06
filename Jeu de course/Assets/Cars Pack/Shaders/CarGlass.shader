// Shader created with Shader Forge Beta 0.25 
// Shader Forge (c) Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:0.25;sub:START;pass:START;ps:flbk:,lico:1,lgpr:1,nrmq:1,limd:1,uamb:False,mssp:True,lmpd:False,lprd:False,enco:False,frtr:True,vitr:True,dbil:False,rmgx:False,hqsc:True,hqlp:False,blpr:1,bsrc:3,bdst:7,culm:0,dpts:2,wrdp:False,ufog:True,aust:True,igpj:True,qofs:0,qpre:3,rntp:2,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:1,fgcg:1,fgcb:1,fgca:1,fgde:0,fgrn:8.54,fgrf:35.5,ofsf:0,ofsu:0;n:type:ShaderForge.SFN_Final,id:1,x:32550,y:32744|diff-5-OUT,spec-13-OUT,gloss-208-OUT,emission-63-OUT,alpha-132-OUT;n:type:ShaderForge.SFN_Tex2d,id:2,x:33373,y:32700,ptlb:Dirt (B),tex:e71f528961d725f49b9a55b8594486d9,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Color,id:4,x:33259,y:32508,ptlb:Diffuse,c1:0.6364619,c2:0.7158334,c3:0.7941176,c4:1;n:type:ShaderForge.SFN_Multiply,id:5,x:33064,y:32700|A-4-RGB,B-2-R;n:type:ShaderForge.SFN_Slider,id:9,x:33239,y:32949,ptlb:Specular,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Multiply,id:13,x:33064,y:32832|A-2-B,B-9-OUT;n:type:ShaderForge.SFN_Cubemap,id:47,x:33201,y:33046,ptlb:Cube,cube:9735752e88672c940bf92e2baf95d78b,pvfc:0;n:type:ShaderForge.SFN_Multiply,id:63,x:32912,y:32911|A-13-OUT,B-47-RGB;n:type:ShaderForge.SFN_Slider,id:132,x:32880,y:33126,ptlb:Opacity,min:0,cur:1,max:1;n:type:ShaderForge.SFN_Vector1,id:208,x:32829,y:32832,v1:24;proporder:4-9-132-2-47;pass:END;sub:END;*/

Shader "Custom/Car Glass" {
    Properties {
        _Diffuse ("Diffuse", Color) = (0.6364619,0.7158334,0.7941176,1)
        _Specular ("Specular", Range(0, 1)) = 1
        _Opacity ("Opacity", Range(0, 1)) = 1
        _DirtB ("Dirt (B)", 2D) = "white" {}
        _Cube ("Cube", Cube) = "_Skybox" {}
        [HideInInspector]_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Transparent"
            "RenderType"="Transparent"
        }
        Pass {
            Name "ForwardBase"
            Tags {
                "LightMode"="ForwardBase"
            }
            Blend SrcAlpha OneMinusSrcAlpha
            ZWrite Off
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDBASE
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform sampler2D _DirtB; uniform float4 _DirtB_ST;
            uniform float4 _Diffuse;
            uniform float _Specular;
            uniform samplerCUBE _Cube;
            uniform float _Opacity;
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
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.uv0 = v.uv0;
                o.normalDir = mul(float4(v.normal,0), _World2Object).xyz;
                o.posWorld = mul(_Object2World, v.vertex);
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
/////// Normals:
                float3 normalDirection =  i.normalDir;
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = 1;
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = dot( normalDirection, lightDirection );
                float3 diffuse = max( 0.0, NdotL) * attenColor;
////// Emissive:
                float2 node_221 = i.uv0;
                float4 node_2 = tex2D(_DirtB,TRANSFORM_TEX(node_221.rg, _DirtB));
                float node_13 = (node_2.b*_Specular);
                float3 emissive = (node_13*texCUBE(_Cube,viewReflectDirection).rgb);
///////// Gloss:
                float gloss = 24.0;
////// Specular:
                NdotL = max(0.0, NdotL);
                float3 specularColor = float3(node_13,node_13,node_13);
                float3 specular = (floor(attenuation) * _LightColor0.xyz) * pow(max(0,dot(halfDirection,normalDirection)),gloss) * specularColor;
                float3 finalColor = 0;
                float3 diffuseLight = diffuse;
                finalColor += diffuseLight * (_Diffuse.rgb*node_2.r);
                finalColor += specular;
                finalColor += emissive;
/// Final Color:
                return fixed4(finalColor,_Opacity);
            }
            ENDCG
        }
        Pass {
            Name "ForwardAdd"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            ZWrite Off
            
            Fog { Color (0,0,0,0) }
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #define UNITY_PASS_FORWARDADD
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd
            #pragma target 3.0
            uniform float4 _LightColor0;
            uniform sampler2D _DirtB; uniform float4 _DirtB_ST;
            uniform float4 _Diffuse;
            uniform float _Specular;
            uniform samplerCUBE _Cube;
            uniform float _Opacity;
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
                float3 halfDirection = normalize(viewDirection+lightDirection);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = dot( normalDirection, lightDirection );
                float3 diffuse = max( 0.0, NdotL) * attenColor;
///////// Gloss:
                float gloss = 24.0;
////// Specular:
                NdotL = max(0.0, NdotL);
                float2 node_222 = i.uv0;
                float4 node_2 = tex2D(_DirtB,TRANSFORM_TEX(node_222.rg, _DirtB));
                float node_13 = (node_2.b*_Specular);
                float3 specularColor = float3(node_13,node_13,node_13);
                float3 specular = attenColor * pow(max(0,dot(halfDirection,normalDirection)),gloss) * specularColor;
                float3 finalColor = 0;
                float3 diffuseLight = diffuse;
                finalColor += diffuseLight * (_Diffuse.rgb*node_2.r);
                finalColor += specular;
/// Final Color:
                return fixed4(finalColor * _Opacity,0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
