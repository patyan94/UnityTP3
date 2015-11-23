using UnityEngine;
using System.Collections;

public class ProjectileBehaviour : MonoBehaviour
{

	public enum ProjectileType
	{
		RED = 0,
		BLUE,
		GREEN
	}
	;

	bool m_shoot = false;
	Vector3 m_direction;
	public float speed = 100f;
	public ProjectileType proType;
	public float damage = 35.0f;
	public GameObject targetPicker;
	public GameObject explosion;
	public int MaxRebound = 0;
	int reboundCount = 0;
	GameObject target;
	CarController parentCar;
	GameObject gameManager;
	GameObject track;

	// Use this for initialization
	void Start ()
	{
		GetComponent<Rigidbody> ().velocity = Vector3.zero;
		gameManager = GameObject.FindGameObjectWithTag ("GameManager");
		track = GameObject.FindGameObjectWithTag ("Track");
		Physics.IgnoreCollision (track.GetComponent<Collider> (), GetComponent<Collider> ());

	}

	void FixedUpdate ()
	{

		if (m_shoot) {
			handleShooting ();
		}
		if(proType == ProjectileType.GREEN)
			handleRebounding ();
	}

	void handleRebounding ()
	{
		if ((MaxRebound - reboundCount) <= 0)
			Destroy (this);
	}

	void handleShooting ()
	{
		m_direction = (target.transform.position - transform.position).normalized;
		rigidbody.velocity = m_direction * speed;
	}

	void OnTriggerEnter (Collider other)
	{
		if(other.transform.parent && (other.transform.parent.tag == "Wall" || other.transform.parent.tag == "Obstacles")){
			GameObject tempExplosion = Instantiate (explosion, transform.position, Quaternion.identity) as GameObject;
			Destroy(other);
			Destroy (this);
		}
		else if (other.transform.parent && other.transform.parent.tag != "Checkpoint") {

				//Debug.Log ("Hit");
				other.transform.parent.SendMessageUpwards ("receiveDamage", damage, SendMessageOptions.DontRequireReceiver);
				GameObject tempExplosion = Instantiate (explosion, transform.position, Quaternion.identity) as GameObject;
				if (proType == ProjectileType.BLUE && target != null && target.GetInstanceID () == other.transform.parent.parent.GetInstanceID ()) {
					//Debug.Log ("Hit Target");
					Destroy (this);
				} else if (proType == ProjectileType.RED)
					Destroy (this);
			//Debug.Log (other.transform.ToString ());
		}
			
	}

	public void SetParentCar (CarController car)
	{
		parentCar = car;
	}

	void Shoot (Vector3 direction)
	{

		m_direction = direction;
		m_shoot = true;
		gameManager = GameObject.FindGameObjectWithTag ("GameManager");
		if (gameManager == null)
			return;

		if (proType == ProjectileType.RED && gameManager.GetComponent<CheckpointManager> ().getNext (parentCar)) {
			target = gameManager.GetComponent<CheckpointManager> ().getNext (parentCar).gameObject;
		} else if (proType == ProjectileType.BLUE) {
			target = gameManager.GetComponent<CheckpointManager> ().getFirstCar ().gameObject;
		}
	}


}
