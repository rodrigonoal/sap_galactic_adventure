using SpacefarerService as service from '../../srv/spacefarers-service';

annotate service.GalacticSpacefarers with @(UI: {
    FieldGroup #Default                : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'Name',
                Value: name,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Email',
                Value: email,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Origin Planet',
                Value: originPlanet,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Position',
                Value: position.name,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Spacesuit Color',
                Value: spacesuitColor,
            },
            {
                $Type : 'UI.DataFieldForAnnotation',
                Label : 'Stardust Collection',
                Target: '@UI.DataPoint#StardustCollectionBar',
            },
            {
                $Type : 'UI.DataFieldForAnnotation',
                Label : 'Wormhole Navigation Skill',
                Target: '@UI.DataPoint#WormholeNavigationRating',
            },

        ],
    },
    Facets                             : [{
        $Type : 'UI.ReferenceFacet',
        ID    : 'DefaultFacet',
        Label : 'Spacefarer Information',
        Target: '@UI.FieldGroup#Default',
    }, ],
    HeaderInfo                         : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Galactic Spacefarer',
        TypeNamePlural: 'Galactic Spacefarers'
    },
    SelectionFields                    : [position_ID,
                                                       // position.department_ID // filter selection
                                         ],
    DataPoint #WormholeNavigationRating: {
        Value        : wormholeNavigationSkill,
        TargetValue  : 10,
        Visualization: #Rating
    },
    DataPoint #StardustCollectionBar   : {
        Value        : stardustCollection,
        TargetValue  : 255,
        Visualization: #Progress
    },
    LineItem                           : [
        {
            $Type: 'UI.DataField',
            Label: 'Email',
            Value: email,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Spacesuit Color',
            Value: spacesuitColor,
        },
        {
            $Type            : 'UI.DataFieldForAnnotation',
            Label            : 'Stardust Collection',
            Target           : '@UI.DataPoint#StardustCollectionBar',
            ![@UI.Importance]: #High
        },
        {
            $Type            : 'UI.DataFieldForAnnotation',
            Label            : 'Wormhole Navigation Skill',
            Target           : '@UI.DataPoint#WormholeNavigationRating',
            ![@UI.Importance]: #High,
        },
        {
            $Type            : 'UI.DataField',
            Value            : position.name,
            Label            : 'Position',
            ![@UI.Importance]: #High,
        },
        {
            $Type: 'UI.DataField',
            Value: originPlanet,
            Label: 'Origin Planet',
        },
        {
            $Type            : 'UI.DataField',
            Value            : position.department_ID,
            Label            : 'Department ID',
            ![@UI.Importance]: #Low,

        },
        {
            $Type            : 'UI.DataField',
            Value            : position_ID,
            Label            : 'Position ID',
            ![@UI.Importance]: #Low,

        },
    ],
}

);

annotate service.GalacticSpacefarers with {
    position @Common.ValueList: {
        $Type         : 'Common.ValueListType',
        CollectionPath: 'Positions',
        Parameters    : [
            {
                $Type            : 'Common.ValueListParameterInOut',
                LocalDataProperty: position_ID,
                ValueListProperty: 'ID',
            },
            {
                $Type            : 'Common.ValueListParameterDisplayOnly',
                ValueListProperty: 'name'
            },
        ],
    }
};

// FILTER OPTIONS FOR DEPARTMENT
// annotate service.GalacticSpacefarers with {
//     department @Common.ValueList: {
//         $Type         : 'Common.ValueListType',
//         CollectionPath: 'Departments',
//         Parameters    : [
//             {
//                 $Type            : 'Common.ValueListParameterInOut',
//                 LocalDataProperty: position.department_ID,
//                 ValueListProperty: 'ID',
//             },
//             {
//                 $Type            : 'Common.ValueListParameterDisplayOnly',
//                 ValueListProperty: 'name'
//             },
//         ],
//     }
// };

annotate SpacefarerService.GalacticSpacefarers with {
    name                    @title: 'Name';
    stardustCollection      @title: 'Stardust Collection';
    wormholeNavigationSkill @title: 'Wormhole Navigation Skill';
    originPlanet            @title: 'Origin Planet';
    spacesuitColor          @title: 'Spacesuit Color';
    email                   @title: 'Email';
    position                @title: 'Position'
}
