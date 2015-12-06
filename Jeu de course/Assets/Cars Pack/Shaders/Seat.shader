// Shader created with Shader Forge Beta 0.25 
// Shader Forge (c) Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:0.25;sub:START;pass:START;ps:flbk:,lico:0,lgpr:1,nrmq:1,limd:1,uamb:True,mssp:True,lmpd:False,lprd:False,enco:False,frtr:True,vitr:True,dbil:False,rmgx:True,hqsc:True,hqlp:False,blpr:0,bsrc:0,bdst:0,culm:0,dpts:2,wrdp:True,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:1,fgcg:1,fgcb:1,fgca:1,fgde:0,fgrn:8.54,fgrf:35.5,ofsf:0,ofsu:0;n:type:ShaderForge.SFN_Final,id:1,x:32340,y:32727|diff-10-OUT;n:type:ShaderForge.SFN_VertexColor,id:2,x:33121,y:32773;n:type:ShaderForge.SFN_Multiply,id:3,x:32939,y:32712|A-4-RGB,B-2-RGB;n:type:ShaderForge.SFN_Color,id:4,x:33121,y:32630,ptlb:Color,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Fresnel,id:5,x:32939,y:32932|EXP-7-OUT;n:type:ShaderForge.SFN_Slider,id:7,x:33140,y:32978,ptlb:Fresnel Factor,min:0,cur:1.902256,max:10;n:type:ShaderForge.SFN_Multiply,id:8,x:32769,y:32981|A-5-OUT,B-9-OUT;n:type:ShaderForge.SFN_Slider,id:9,x:32990,y:33134,ptlb:Fresnel,min:0,cur:0.443609,max:1;n:type:ShaderForge.SFN_Multiply,id:10,x:32648,y:32691|A-3-OUT,B-8-OUT;proporder:4-7-9;pass:END;sub:END;*/

Shader "Custom/Seat" {
    Properties {
        _Color ("Color", Color) = (1,1,1,1)
        _FresnelFactor ("Fresnel Factor", Range(0, 10)) = 1.902256
        _Fresnel ("Fresnel", Range(0, 1)) = 0.443609
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
            uniform float4 _LightColor0;
            uniform float4 _Color;
            uniform float _FresnelFactor;
            uniform float _Fresnel;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 vertexColor : COLOR;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                float4 vertexColor : COLOR;
                LIGHTING_COORDS(2,3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.vertexColor = v.vertexColor;
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
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
                float3 attenColor = attenuation * _LightColor0.xyz;
/////// Diffuse:
                float NdotL = dot( normalDirection, lightDirection );
                float3 diffuse = max( 0.0, NdotL) * attenColor + UNITY_LIGHTMODEL_AMBIENT.xyz;
                float3 finalColor = 0;
                float3 diffuseLight = diffuse;
                finalColor += diffuseLight * ((_Color.rgb*i.vertexColor.rgb)*(pow(1.0-max(0,dot(normalDirection, viewDirection)),_FresnelFactor)*_Fresnel));
/// Final Color:
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
