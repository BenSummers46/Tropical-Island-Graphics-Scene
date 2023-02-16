using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CubeGenerator : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        CreateMesh();
    }

    private void CreateMesh()
    {
        Vector3[] vertices =
        {
            new Vector3 (0, 0, 0),
            new Vector3 (2, 0, 0),
            new Vector3 (2, 2, 0),
            new Vector3 (0, 2, 0),
            new Vector3 (0, 2, 2),
            new Vector3 (2, 2, 2),
            new Vector3 (2, 0, 2),
            new Vector3 (0, 0, 2),
        };

        int[] triangles =
        {
            0, 2, 1,
            0, 3, 2,
            2, 3, 4,
            2, 4, 5,
            1, 2, 5,
            1, 5, 6,
            0, 7, 4,
            0, 4, 3,
            5, 4, 7,
            5, 7, 6,
            0, 6, 7,
            0, 1, 6
        };

        Mesh mesh = GetComponent<MeshFilter>().mesh;
        mesh.Clear();
        mesh.vertices = vertices;
        mesh.triangles = triangles;
        mesh.Optimize();
        mesh.RecalculateNormals();
    }
}
