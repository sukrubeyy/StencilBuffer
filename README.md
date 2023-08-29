# StencilBuffer

<img src="https://github.com/sukrubeyy/StencilBuffer/blob/main/Assets/Images/StencialBuffer.gif"/>

<ul>
<li>Stencil Read</li>
<p> The object that will render the referenced object.</p>
<pre>
<code>
Shader "Unlit/StencilRead"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Maincolor("Main Color",Color)=(1,1,1,1)
        
        [IntRange] _StencilRef ("Stencil Reference Value", Range(0,255)) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        Stencil{
            //Referans Değeri
            Ref [_StencilRef]
            //Stencil İşleminin ne zaman gerçekleşeceğini belirliyor
            Comp Equal
        }
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float4 _Maincolor;
            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return _Maincolor;
            }
            ENDCG
        }
    }
}

</code>
</pre>

<li>Stencil Write</li>

<pre>
<code>
Shader "Unlit/StencialWrite"
{
    Properties
    {
    [IntRange] _StencilRef ("Stencil Reference Value", Range(0,255)) = 0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" "Queue"="Geometry-1"}
        LOD 100
        Stencil{
            Ref [_StencilRef]
            Comp Always
            Pass Replace
                }
        Pass
        {
            //Bu, gölgelendirici tarafından döndürülen rengin tamamen yok sayılacağı ve 
            //daha önce oluşturulan rengin tamamen korunacağı anlamına gelir.
            Blend Zero One
            ZWrite Off

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

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            float4 frag (v2f i) : SV_Target
            {
                return 0;
            }
            ENDCG
        }
    }
}
</code>
</pre>
</ul>

