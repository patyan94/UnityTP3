using UnityEngine;
using System.Collections;

public class RedProjectile : MonoBehaviour {

	public GameObject explosion;
	public float damage = 35.0f;
	public float speed = 100f;
	GameObject target;
	
	
	Vector3 direction;
	
	// Use this for initialization
	void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		
	}
	
	void FixedUpdate () {
		rigidbody.velocity = (target.transform.position - transform.position).normalized * speed;
	}

	void Shoot (GameObject parent)
	{
		target = (GameObject.FindGameObjectWithTag("GameManager") as GameObject).GetComponent<CheckpointManager> ().getNext (parent.GetComponent<CarController>()).gameObject as GameObject;
	}
	
	void OnCollisionEnter(Collision other)
	{
		other.collider.transform.parent.SendMessageUpwards ("receiveDamage", damage, SendMessageOptions.DontRequireReceiver);
		GameObject tempExplosion = Instantiate (explosion, transform.position, Quaternion.identity) as GameObject;
		Destroy (this);
	}
}
