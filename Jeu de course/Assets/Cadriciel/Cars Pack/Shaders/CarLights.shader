// Shader created with Shader Forge Beta 0.25 
// Shader Forge (c) Joachim Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:0.25;sub:START;pass:START;ps:flbk:,lico:1,lgpr:1,nrmq:1,limd:1,uamb:True,mssp:True,lmpd:False,lprd:False,enco:False,frtr:True,vitr:True,dbil:False,rmgx:True,hqsc:True,hqlp:False,blpr:0,bsrc:0,bdst:0,culm:0,dpts:2,wrdp:True,ufog:True,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:1,fgcg:1,fgcb:1,fgca:1,fgde:0,fgrn:8.54,fgrf:35.5,ofsf:0,ofsu:0;n:type:ShaderForge.SFN_Final,id:1,x:32533,y:32629|emission-5-OUT;n:type:ShaderForge.SFN_Tex2d,id:2,x:33177,y:32761,ptlb:Lightmap (R),ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:3,x:32984,y:32700|A-4-RGB,B-2-R;n:type:ShaderForge.SFN_Color,id:4,x:33177,y:32588,ptlb:Color,c1:1,c2:0.8155173,c3:0.2132353,c4:1;n:type:ShaderForge.SFN_Multiply,id:5,x:32789,y:32722|A-3-OUT,B-6-OUT;n:type:ShaderForge.SFN_Slider,id:6,x:33014,y:32919,ptlb:Brightness,min:0,cur:0.3233083,max:10;proporder:4-6-2;pass:END;sub:END;*/

Shader "Custom/Lights" {
    Properties {
        _Color ("Color", Color) = (1,0.8155173,0.2132353,1)
        _Brightness ("Brightness", Range(0, 10)) = 0.3233083
        _LightmapR ("Lightmap (R)", 2D) = "white" {}
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
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform sampler2D _LightmapR; uniform float4 _LightmapR_ST;
            uniform float4 _Color;
            uniform float _Brightness;
            struct VertexInput {
                float4 vertex : POSITION;
                float4 uv0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 uv0 : TEXCOORD0;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o;
                o.uv0 = v.uv0;
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
                return o;
            }
            fixed4 frag(VertexOutput i) : COLOR {
////// Lighting:
////// Emissive:
                float2 node_16 = i.uv0;
                float3 emissive = ((_Color.rgb*tex2D(_LightmapR,TRANSFORM_TEX(node_16.rg, _LightmapR)).r)*_Brightness);
                float3 finalColor = emissive;
/// Final Color:
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
