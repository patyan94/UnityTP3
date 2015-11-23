using UnityEngine;
using System.Collections;

public class Spawner : MonoBehaviour {

	public GameObject Prefab;
	GameObject Object = null;
	public float SpawningTime = 2.0f;
	float ellapsedTime = 0.0f;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		
		if (Object)
			ellapsedTime = 0.0f;
		else {
			ellapsedTime += Time.deltaTime;
			if (ellapsedTime > SpawningTime) {
				Object = GameObject.Instantiate (Prefab, transform.position, Prefab.transform.rotation) as GameObject;
			}
		}
	}

}
