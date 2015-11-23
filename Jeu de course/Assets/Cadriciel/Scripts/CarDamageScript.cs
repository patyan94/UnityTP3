using UnityEngine;
using UnityEngine.UI;
using System.Collections;

public class CarDamageScript : MonoBehaviour {

	[SerializeField]
	public float lifePointsMax = 100f;

	public float lifePoints = 100f;
	[SerializeField]
	private float maxSmokeEnergie;

	[SerializeField]
	ParticleEmitter damageSmoke;
	[SerializeField]
	ParticleAnimator damageSmokeAnimator;

	[SerializeField]
	float forceImpactMin;
	[SerializeField]
	float damageConstant;

	public Text LpText;

	// Use this for initialization
	void Start () {
		damageSmoke.maxEnergy = 0.0f;
	}

	void receiveDamage(float damage){

		lifePoints = Mathf.Clamp ((lifePoints - damage), 0.0f, lifePointsMax);
		//Debug.Log (this.ToString() + "Health : " + lifePoints.ToString ());

		if (lifePoints <= 0) {
            SendMessage("ReSpawn");
			lifePoints = lifePointsMax;
		}
	}

	void Heal(){
		lifePoints = Mathf.Clamp ((lifePoints + 30.0f), 0.0f, lifePointsMax);
	}

	void OnCollisionEnter (Collision other)
	{		
		//Debug.Log("Coll : " + other.relativeVelocity.magnitude);
		if(other.relativeVelocity.magnitude > forceImpactMin){
			receiveDamage(damageConstant);
		}
	}

	// Update is called once per frame
	void Update () {

		damageSmoke.maxEnergy = (1-(lifePoints / lifePointsMax)) * maxSmokeEnergie;
		
		//Debug.Log (lifePoints.ToString ());
		
		if (lifePoints <= 20) {
			Color[] smokecolor = damageSmokeAnimator.colorAnimation;
			smokecolor [0] = Color.red;
			damageSmokeAnimator.colorAnimation = smokecolor; 
		} else {
			Color[] smokecolor = damageSmokeAnimator.colorAnimation;
			smokecolor [0] = Color.grey;
		}
		if(LpText)
			LpText.text = lifePoints.ToString ();
	}
}
