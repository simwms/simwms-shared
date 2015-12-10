import DS from 'ember-data';
import {UnderscoreSerializer} from 'simwms-shared';

export default DS.JSONAPISerializer.extend(UnderscoreSerializer, {});