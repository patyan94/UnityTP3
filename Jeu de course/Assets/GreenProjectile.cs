using UnityEngine;
using System.Collections;

public class GreenProjectile : MonoBehaviour {
	
	public GameObject explosion;
	public int MaxRebound = 0;
	int reboundCount = 0;
	public float damage = 35.0f;
	public float speed = 100f;


	Vector3 direction;

	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
	
	}

	void FixedUpdate () {
		rigidbody.velocity = direction;
	}

	void ShootGreen (Vector3 direction)
	{
		this.direction = direction * speed;
	}

	void OnCollisionEnter(Collision other)
	{
		if(other.gameObject.CompareTag("Wall") || other.gameObject.CompareTag("Obstacles")){
			if(reboundCount++ >= MaxRebound){
				GameObject tempExplosion = Instantiate (explosion, transform.position, Quaternion.identity) as GameObject;
				Destroy(other.collider.gameObject);
				Destroy (this);
			}
			
		}
		else if (other.gameObject.CompareTag("Player")) {
				other.gameObject.SendMessageUpwards ("receiveDamage", damage, SendMessageOptions.DontRequireReceiver);
				if(reboundCount++ >= MaxRebound){
					GameObject tempExplosion = Instantiate (explosion, transform.position, Quaternion.identity) as GameObject;
					Destroy (this);
			}
		}
		direction = rigidbody.velocity;
	}
}
