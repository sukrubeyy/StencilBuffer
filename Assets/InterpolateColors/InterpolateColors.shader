Shader "Unlit/InterpolateColors"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _FirstColor("First Color",Color)=(1,1,1,1)
        _SecondColor("Second Color",Color)=(1,1,1,1)
        _BlendValue("Blend Value",Range(0,1))=0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float4 _FirstColor;
            float4 _SecondColor;
            float _BlendValue;
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                float4 col = _FirstColor+_SecondColor*_BlendValue;
                return col;
            }
            ENDCG
        }
    }
}
