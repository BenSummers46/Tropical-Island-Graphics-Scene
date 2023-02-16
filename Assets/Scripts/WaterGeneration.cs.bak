using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WaterGeneration : MonoBehaviour
{
    public float size = 128f;
    public int fidelity = 128;

    private MeshFilter meshFilter;

    // Start is called before the first frame update
    void Start()
    {
        meshFilter = GetComponent<MeshFilter>();
        meshFilter.mesh = GenerateMesh();
    }

    private Mesh GenerateMesh()
    {
        Mesh waterMesh = new Mesh();

        List<Vector3> meshVertices = new List<Vector3>();
        List<Vector3> meshNormals = new List<Vector3>();
        List<Vector2> meshuvs = new List<Vector2>();

        for(int i = 0; i < fidelity + 1; i++)
        {
            for(int j = 0; j < fidelity + 1; j++)
            {
                float x = -size * 0.5f + size * (i / ((float)fidelity));
                float y = -size * 0.5f + size * (j / ((float)fidelity));
                meshVertices.Add(new Vector3(x, 0, y));
                meshNormals.Add(Vector3.up);
                meshuvs.Add(new Vector2(i / (float)fidelity, j / (float)fidelity));
            }
        }

        List<int> triangles = new List<int>();
        int vertexAmount = fidelity + 1;
        for(int h = 0; h < vertexAmount * vertexAmount - vertexAmount; h++)
        {
            if ((h + 1) % vertexAmount == 0)
            {
                continue;
            }
            triangles.AddRange(new List<int>()
            {
                h+1+vertexAmount, h+vertexAmount, h,
                h, h+1, h+vertexAmount+1
            });
        }

        waterMesh.SetVertices(meshVertices);
        waterMesh.SetNormals(meshNormals);
        waterMesh.SetUVs(0, meshuvs);
        waterMesh.SetTriangles(triangles, 0);

        return waterMesh;
    }

}
