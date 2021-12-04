// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Unity6000/Part1/Vertex_Fragment Shader"
{
    //属性块
    Properties
    {
        _MainTex("My texture",2D) = "white"{}
        _Diffuse("DiffuseColor",Color)  = (1,1,1,1)
    }
    
    SubShader 
    {
        Tags 
        {
            "RenderType" = "Opaque"
        }
        LOD 100
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityShaderUtilities.cginc"
            
            struct VertInput
            {
                float4 pos : POSITION; //pos in Object space (local space
            };

            struct VertexOutput
            {
                float4 pos : SV_POSITION; //SV System Value Pos In Projection space
            };

            VertexOutput vert(VertInput IN)
            {
                VertexOutput o;
                o.pos = UnityObjectToClipPos(IN.pos.xyz);
                // o.pos = mul(UNITY_MATRIX_MVP, o.pos.xyz);//把一个物体的顶点变换为投影空间的顶点，UNITY_MATRIX_MVP ModelViewProjectiong
                return o;
            }

            half4 _Diffuse;
            
            half4 frag(VertexOutput IN) : COLOR
            {
                return _Diffuse;
            } 
            ENDCG
        }
    }    
}
