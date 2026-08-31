Shader "Custom/GrayScaleUI" // Shader name
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {} // Exposed in editor
    }
    SubShader
    {
        // How shader should behave
        Tags
        {
            "Queue"="Transparent"
            "RenderType"="Transparent" // can use alpha
            "IgnoreProjector"="True" // Not need as this is not for 3d
            "CanUseSpriteAtlas"="True" // directly use atlas
        }

        Blend SrcAlpha OneMinusSrcAlpha // blend mode
        ZWrite Off // not 3d no depth
        Cull Off // no culling needed
        
        /* One shader pass
        Vertex
           ↓
        Fragment
           ↓
        Screen
        */

        Pass
        {
            //HLSL/Cg syntax
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc" //Unity's shader helper functions

            //This describes the information coming into the vertex shader.
            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
                fixed4 color : COLOR;
            };

            //It contains the information that the vertex shader sends to the fragment shader.
            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                fixed4 color : COLOR;
            };

            v2f vert(appdata v)
            {
                v2f o;

                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                o.color = v.color;

                return o;
            }

            sampler2D _MainTex;

            fixed4 frag(v2f i) : COLOR
            {
                fixed4 col = tex2D(_MainTex, i.uv);

                // Convert RGB to grayscale
                float grey = dot(
                    col.rgb,
                    float3(0.299, 0.587, 0.114)
                );

                // Apply UI color
                fixed3 finalRGB = grey.xxx * i.color.rgb;

                // Preserve texture alpha and apply UI alpha
                fixed finalAlpha = col.a * i.color.a;

                return fixed4(finalRGB, finalAlpha);
            }
            ENDCG
        }
    }
    FallBack "Sprites/Default"
}