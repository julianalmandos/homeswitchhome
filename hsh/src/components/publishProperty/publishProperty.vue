<template>
  <div class="publish-property">
    <form>
      <div class="form-group">
        <label for="propery-title">Ingrese el nombre de la propiedad</label>
        <input type="property-title" id="property-title" name="property-title">
      </div>

      <div class="form-group">
        <label for="propery-description">Ingrese la descripción de la propiedad</label>
        <input type="property-description" id="property-description" name="property-description">
      </div>

      <div class="form-group">
        <label for="propery-address">Ingrese la dirección de la propiedad</label>
        <input type="property-address" id="property-address" name="property-address">
      </div>

      <div class="form-group">
        <label for="propery-country">Ingrese el país de la propiedad</label>
        <input type="property-country" id="property-country" name="property-country">
      </div>

      <div class="form-group">
        <label for="propery-province">Ingrese la provincia de la propiedad</label>
        <input type="property-province" id="property-province" name="property-province">
      </div>

      <div class="form-group">
        <label for="propery-locality">Ingrese la localidad de la propiedad</label>
        <input type="property-locality" id="property-locality" name="property-locality">
      </div>

      <div class="row">
        <div class="col-sm-6 col-md-4">
          <div class="thumbnail">
            <img data-src="..." alt="...">
            <div class="caption">
              <a href="#" class="btn btn-primary" role="button">Editar imagen</a>
            </div>
          </div>
        </div>
      </div>

      <button type="submit" class="btn btn-primary">Enviar</button>
    </form>
  </div>
</template>

<script>
import { mapState } from "vuex";

export default {
  name: "publishProperty"
};
</script>

