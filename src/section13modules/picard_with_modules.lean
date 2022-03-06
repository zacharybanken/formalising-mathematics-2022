import algebra.category.Module.basic
/-!

# Picard group of a commutative ring

Done with modules.

## Universes

Let's be brave and start using universes.

Instead of `Type`, which we've used all
through the course so far, let's start to
use a "more general Type universe" called
`Type u`. Here the so-called "universe"
`u` is just a natural number (but with much
less API).

Everything we've done so far for `Type`
all works for `Type u`; in fact `Type`
is just `Type 0`.

Some people call `Type u` a "Grothendieck universe".

-/

universe u

/-

Everything we do from now on will take place
in our fixed type universe `Type u` which
we'll never mention again.

## Modules
  
Let `R` be a commutative ring.

-/

variables (R : Type u) [comm_ring R]

/-

Definition: an R-module is just a vector space
over R.

Reminder: a vector space `M` over `R` is
a type `M`, plus a sensible way to add
vectors `m₁ + m₂ : M` together (`add_comm_group M`)
plus a sensible way to multiply a vector
by a scalar `r • m : M` (`module R M`)

-/

section module_basics

variables (M : Type u) [add_comm_group M] [module R M]

end module_basics

/- 

We want to put an equivalence relation on the type of all R-modules,
and the equivalence relation is "we are isomorphic".

Your instinct then is : let's write down the relation like this

-/

def module.r (M₁ : Type u) [add_comm_group M₁] [module R M₁] 
  (M₂ : Type u) [add_comm_group M₂] [module R M₂] : Prop :=
nonempty (M₁ ≃ₗ[R] M₂)


/-

But what is the actual type that this is a relation on? 
I guess it's some crazy pi type which will be hard to use.

-/

structure bundled_module (R : Type u) [comm_ring R] :=
(M : Type u)
[hA : add_comm_group M]
[hM : module R M]

attribute [instance] bundled_module.hA bundled_module.hM

def bundled_module.s : setoid (bundled_module R) :=
{ r := λ I J, nonempty (I.M ≃ₗ[R] J.M),
  iseqv := begin
    -- might be interesting for some people
    sorry
  end }

/-
This type is a bit difficult to deal with because the
typeclasses have been bundled into a structure instead
of the usual method of having them outside. This means
that the type class inference system (the square bracket system)
has a hard time dealing with them. Scott Morrison's idea
is that instead of relying on the typeclass system
(the square bracket system) we should use the category theory
system to manage all the boring stuff like "a module is
an additive monoid" behind the scenes.

In the `picard_with_categories` file we use Lean's implementation
`Module R` of `bundled_module R`. More precisely we use
bundled modules at universe level `u`, namely `Module.{u u} R`.

So I won't continue with this development.

-/
 