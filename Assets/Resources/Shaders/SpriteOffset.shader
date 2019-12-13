Shader "Custom/SpriteOffset" {

Properties {
    [NoScaleOffset] _MainTex ("Texture (RGBA)", 2D) = "white" {}
    _Offset("Offset", Vector) = (1, 1, 0, 0)
}

SubShader
{
    Tags 
    { 
        "Queue"="Transparent"
        "RenderType"="Transparent"
        "IgnoreProjector" = "True" 
        "PreviewType"="Plane" 
        "CanUseSpriteAtlas"="True"
    }

    //subshaders are used for compatibility. If the first subshader isn't compatible, it'll attempt to use the one below it.
    Pass
    {

        Cull Off
        Lighting Off
        ZWrite Off
        Fog { Mode Off }
        Blend One OneMinusSrcAlpha

        CGPROGRAM
            //begin CG block

            #pragma vertex vert
            //we will use a vertex function, named "vert". vert_img is defined in UnityCG.cginc

            #pragma fragment frag
            //we will use a fragment function, named "frag"

            #include "UnityCG.cginc"
            //use a CGInclude file defining several useful functions, including our vertex function

            //declare our external properties
            uniform sampler2D _MainTex;
            uniform half2 _Offset;

            //declare input and output structs for vertex and fragment functions

            struct appdata
            {
                float4 vertex : POSITION;
                half2 texcoord : TEXCOORD0;
                float4 color : COLOR;
            };

            struct v2f
            {
                float4 vertex : SV_POSITION;
                half2 uv : TEXCOORD0;
                fixed4 color : COLOR;
            };

            v2f vert( appdata v )
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.texcoord;
                o.color = v.color;

                return o;
            }

            fixed4 frag(v2f IN) : SV_Target
            {
                fixed4 c = tex2D(_MainTex, frac(IN.uv + _Offset)) * IN.color;
                c.rgb *= c.a;
                return c;
            }
        ENDCG
    }
}
Fallback "Diffuse" //If all of our subshaders aren't compatible, use subshaders from a different shader file
}